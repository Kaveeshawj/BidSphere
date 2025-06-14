//package lk.jiat.ee.web.servlet;
//
//import jakarta.ejb.EJB;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.annotation.WebServlet;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import lk.jiat.ee.ejb.bean.BidServiceBean;
//import lk.jiat.ee.ejb.remote.BidManager;
//
//import java.io.IOException;
//
//@WebServlet("/bid")
//public class BidServlet extends HttpServlet {
//
//    @EJB
//    private BidServiceBean bidService;
//
//    @EJB
//    private BidManager bidManager;
//
//    private static final int BASE_PRICE = 500000;
//
//    @Override
//    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        String bidStr = req.getParameter("bid");
//        String username = (String) req.getSession().getAttribute("user");
//        String maxBidStr = req.getParameter("max-bid");
//
//
//        if (bidStr == null || bidStr.trim().isEmpty() || username == null) {
//            req.setAttribute("error", "Invalid bid or user session.");
//            forwardToHistory(req, resp);
//            return;
//        }
//
//        try {
//            int bidAmount = Integer.parseInt(bidStr.trim());
//            int maxBidAmount = maxBidStr != null && !maxBidStr.trim().isEmpty()
//                    ? Integer.parseInt(maxBidStr.trim())
//                    : bidAmount;
//
//            if (bidAmount <= BASE_PRICE) {
//                req.setAttribute("error", "Bid must be greater than base price ₹" + BASE_PRICE + ".");
//                forwardToHistory(req, resp);
//                return;
//            }
//
//            int currentHighest = bidManager.getHighestBid();
//            String currentHighestUser = bidManager.getHighestBidder();
//
//            if (bidAmount <= currentHighest) {
//                req.setAttribute("error", "Bid must be higher than the current highest bid ₹" + currentHighest + ".");
//            } else {
//                if (!username.equals(currentHighestUser)) {
//                    // New highest bidder
//                    if (maxBidAmount > bidAmount) {
//                        bidService.placeAutoBid(username, maxBidAmount, bidAmount);
//                    } else {
//                        bidService.placeManualBid(username, bidAmount);
//                    }
//                } else {
//                    // Existing highest bidder updating max bid
//                    bidService.placeAutoBid(username, maxBidAmount, bidAmount);
//                }
//
//                req.setAttribute("success", "Bid placed successfully.");
//            }
//
//        } catch (NumberFormatException e) {
//            req.setAttribute("error", "Invalid number format.");
//        } catch (Exception e) {
//            req.setAttribute("error", "Unexpected error: " + e.getMessage());
//            e.printStackTrace();
//        }
//
//        req.setAttribute("bidHistory", bidManager.getAllBids());
//        forwardToHistory(req, resp);
//
//
//    }
//
//    // Place this inside your BidServlet class
//    private void forwardToHistory(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//        req.getRequestDispatcher("/bidding-history.jsp").forward(req, resp);
//    }
//
//}
//
//
//
//
//
//


package lk.jiat.ee.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import jakarta.servlet.ServletException;
import lk.jiat.ee.ejb.bean.BidServiceBean;
import lk.jiat.ee.ejb.remote.BidManager;

import java.io.IOException;

@WebServlet("/bid")
public class BidServlet extends HttpServlet {

    @EJB
    private BidServiceBean bidService;

    @EJB
    private BidManager bidManager;

    private static final int BASE_PRICE = 500000;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String bidStr = req.getParameter("bid");
        String maxStr = req.getParameter("max-bid");
        String username = (String) req.getSession().getAttribute("user");

        if (bidStr == null || username == null) {
            resp.sendRedirect("bidding-history?error=invalid_bid");
            return;
        }

        try {
            int bidAmount = Integer.parseInt(bidStr);
            int maxBid = (maxStr != null && !maxStr.isEmpty()) ? Integer.parseInt(maxStr) : bidAmount;

            if (bidAmount < BASE_PRICE) {
                resp.sendRedirect("bidding-history?error=bid_below_base_price");
                return;
            }

            int current = bidManager.getHighestBid();
            if (bidAmount <= current) {
                resp.sendRedirect("bidding-history?error=bid_too_low");
                return;
            }

            if (maxBid > bidAmount) {
                bidService.placeAutoBid(username, maxBid, bidAmount);
            } else {
                bidService.placeManualBid(username, bidAmount);
            }

            resp.sendRedirect("bidding-history?success=true");

        } catch (NumberFormatException e) {
            resp.sendRedirect("bidding-history?error=invalid_format");
        }
    }
}
