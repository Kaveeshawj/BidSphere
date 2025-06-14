package lk.jiat.ee.ejb.bean;

import jakarta.annotation.Resource;
import jakarta.ejb.EJB;
import jakarta.ejb.Stateless;
import jakarta.jms.ConnectionFactory;
import jakarta.jms.JMSContext;
import jakarta.jms.Topic;
import lk.jiat.ee.ejb.remote.BidManager;

import java.util.ArrayList;
import java.util.List;

@Stateless
public class BidServiceBean {
    @Resource(lookup = "jms/MyConnectionFactory")
    private ConnectionFactory connectionFactory;

    @Resource(lookup = "jms/MyTopic")
    private Topic topic;

    @EJB
    private BidManager bidManager;

    private final List<String> bidList = new ArrayList<>();

    public void storeBid(String bid) {
        System.out.println("Storing bid: " + bid);
        bidList.add(bid);
    }

    public void placeManualBid(String bidder, int amount) {
        bidManager.addManualBid(bidder, amount);
        sendJmsMessage("Manual bid: " +  bidder + ": " + amount);

    }

    public void placeAutoBid(String bidder, int maxAmount, int actualBidAmount) {
        bidManager.placeAutoBid(bidder, maxAmount, actualBidAmount);
        sendJmsMessage("Auto bid by " + bidder + ": initial=" + actualBidAmount+ ", max=" + maxAmount);
    }

    private void sendJmsMessage(String bidDetails) {
        try (JMSContext context = connectionFactory.createContext()) {
            context.createProducer().send(topic, bidDetails);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}



