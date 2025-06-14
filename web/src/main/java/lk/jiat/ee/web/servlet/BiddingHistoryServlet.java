package lk.jiat.ee.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.ee.ejb.remote.BidManager;
import model.BidEntry;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

@WebServlet("/bidding-history")
public class BiddingHistoryServlet extends HttpServlet {

    @EJB
    private BidManager bidManager;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String ajaxRequest = req.getHeader("X-Requested-With");
        boolean isAjax = "XMLHttpRequest".equals(ajaxRequest) || "true".equals(req.getParameter("ajax"));

        List<BidEntry> bidHistory = bidManager.getAllBids();
        Collections.reverse(bidHistory);

        req.setAttribute("bidHistory", bidHistory);

        int highestBid = bidManager.getHighestBid();
        req.setAttribute("highestBid", highestBid);

        System.out.println("highestBid: " + highestBid);
        String error = req.getParameter("error");
        if (error != null) {
            switch (error) {
                case "bid_below_base_price":
                    req.setAttribute("errorMessage", "Bid must be higher than the base price of Rs. 500,000.00!");
                    break;
                case "bid_too_low":
                    req.setAttribute("errorMessage", "Your bid must be higher than the current highest bid!");
                    break;
                case "invalid_format":
                    req.setAttribute("errorMessage", "Please enter a valid number for your bid.");
                    break;
                case "invalid_bid":
                    req.setAttribute("errorMessage", "Invalid bid or you must be logged in to bid.");
                    break;
            }
        }

        if (isAjax) {
            req.getRequestDispatcher("/bid-table.jsp").forward(req, resp);
        } else {
            // For regular requests, return the full page
            req.getRequestDispatcher("/bidding-history.jsp").forward(req, resp);
        }
    }

}



