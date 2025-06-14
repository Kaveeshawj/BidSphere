package lk.jiat.ee.web.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.UserStore;
import model.User;

import java.io.IOException;

@WebServlet("/SignInServlet")
public class SignInServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        UserStore store = UserStore.getInstance();
        User user = store.getUser(username);

        if (user != null && user.checkPassword(password)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", username);
            response.sendRedirect("auction.jsp");
        } else {
            response.getWriter().println("Invalid credentials");
        }
    }
}

