package lk.jiat.ee.web.servlet;

import jakarta.ejb.EJB;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lk.jiat.ee.ejb.remote.BidManager;

import java.io.IOException;
import java.text.NumberFormat;
import java.util.Locale;

@WebServlet("/AuctionServlet")
public class AuctionServlet extends HttpServlet {


    @EJB
    BidManager bidManager;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        NumberFormat formatter = NumberFormat.getCurrencyInstance(new Locale("en", "LK"));

        double highestBid1 = bidManager.getHighestBid();

        String formattedBid = formatter.format(highestBid1);

        request.setAttribute("highestBid", formattedBid);
        request.getRequestDispatcher("auction.jsp").forward(request, response);
    }

}














