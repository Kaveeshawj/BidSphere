package lk.jiat.ee.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.ee.ejb.bean.BidServiceBean;

import java.io.IOException;

@WebServlet("/home")
public class Home extends HttpServlet {

    @EJB
    private BidServiceBean bidService;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException, IOException {
        String bidParam = req.getParameter("bid");
        String userParam = req.getParameter("user");

        String bidder = userParam != null ? userParam : "guest";
        int amount;

        try {
            amount = bidParam != null ? Integer.parseInt(bidParam) : 100;
        } catch (NumberFormatException e) {
            amount = 100;
        }


        bidService.placeManualBid(bidder, amount);
        resp.getWriter().write("Bid Sent Successfully");
    }
}
