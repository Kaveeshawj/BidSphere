package model;


import java.io.Serializable;
import java.time.LocalDateTime;

public class BidEntry implements Serializable {
    private String bidder;
    private int amount;
    private LocalDateTime timestamp;
    private int maxAmount;

    public BidEntry(String bidder, int amount, int maxAmount, LocalDateTime timestamp) {
        this.bidder = bidder;
        this.amount = amount;
        this.maxAmount = maxAmount;
        this.timestamp = timestamp;
    }

    public String getBidder() {
        return bidder;
    }

    public int getAmount() {
        return amount;
    }

    public int getMaxAmount() {
        return maxAmount;
    }


    public LocalDateTime getTimestamp() {
        return timestamp;
    }
}

