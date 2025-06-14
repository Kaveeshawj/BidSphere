package lk.jiat.ee.ejb.remote;

import jakarta.ejb.Singleton;
import jakarta.ejb.Startup;
import model.BidEntry;

import java.time.LocalDateTime;
import java.util.*;

@Singleton
@Startup
public class BidManager {

    private final List<BidEntry> bids = new ArrayList<>();
    private final Map<String, Integer> userMaxBidMap = new HashMap<>();
    private String highestBidder;
    private boolean auctionEnded = false;
    private final Map<String, Integer> userCurrentBidMap = new HashMap<>();

    public synchronized void addManualBid(String bidder, int amount) {
        if (auctionEnded) return;

        int currentHighest = getHighestBid();

        for (Map.Entry<String, Integer> entry : userMaxBidMap.entrySet()) {
            String autoBidder = entry.getKey();
            int maxBid = entry.getValue();

            if (!autoBidder.equals(bidder) && maxBid >= amount + 10) {
                System.out.println("Manual bid blocked: Auto-bidder can outbid " + bidder);
                return;
            }
        }


        bids.add(new BidEntry(bidder, amount, amount, LocalDateTime.now()));
        highestBidder = bidder;
        userCurrentBidMap.put(bidder, amount);

        autoBidLoop();
    }

    public synchronized void placeAutoBid(String bidder, int maxAmount, int initialAmount) {
        if (auctionEnded) return;

        userMaxBidMap.put(bidder, maxAmount);

        int currentHighest = getHighestBid();

        if (initialAmount > currentHighest) {
            bids.add(new BidEntry(bidder, initialAmount, maxAmount, LocalDateTime.now()));
            highestBidder = bidder;
            userCurrentBidMap.put(bidder, initialAmount);
        } else {
            // Register initial state even if not highest; needed for bidding logic
            int newBid = currentHighest + 5000;
            if (newBid <= maxAmount) {
                bids.add(new BidEntry(bidder, newBid, maxAmount, LocalDateTime.now()));
                highestBidder = bidder;
                userCurrentBidMap.put(bidder, newBid);
            }
        }

        autoBidLoop();
    }

    private synchronized void autoBidLoop() {
        boolean bidUpdated;
        do {
            bidUpdated = false;
            BidEntry current = getLatestBid();
            if (current == null) return;

            String currentBidder = current.getBidder();
            int currentAmount = current.getAmount();

            for (Map.Entry<String, Integer> entry : userMaxBidMap.entrySet()) {
                String bidder = entry.getKey();
                int maxBid = entry.getValue();

                // Skip the current highest bidder
                if (bidder.equals(currentBidder)) continue;

                int bidderCurrentBid = userCurrentBidMap.getOrDefault(bidder, 0);
                int newBid = currentAmount + 10000;

                // Only bid if:
                if (newBid <= maxBid && newBid > bidderCurrentBid) {
                    bids.add(new BidEntry(bidder, newBid, maxBid, LocalDateTime.now()));
                    highestBidder = bidder;
                    userCurrentBidMap.put(bidder, newBid);
                    bidUpdated = true;
                    break; // Break and restart loop so new bidder is challenged again
                }
            }

        } while (bidUpdated);
    }

    public synchronized int getHighestBid() {
        return bids.stream().mapToInt(BidEntry::getAmount).max().orElse(0);
    }

    public synchronized List<BidEntry> getAllBids() {
        return new ArrayList<>(bids);
    }

    public synchronized BidEntry getLatestBid() {
        return bids.isEmpty() ? null : bids.get(bids.size() - 1);
    }

    public synchronized String getHighestBidder() {
        return highestBidder;
    }

    public synchronized void endAuction() {
        auctionEnded = true;
    }

    public synchronized boolean isAuctionEnded() {
        return auctionEnded;
    }

    public void printBidHistory() {
        System.out.println("---- Bid History ----");
        for (BidEntry bid : bids) {
            System.out.println(bid.getTimestamp() + " → " + bid.getBidder() + " bid ₹" + bid.getAmount() + " (max ₹" + bid.getMaxAmount() + ")");
        }
        System.out.println("---------------------");
    }
}
