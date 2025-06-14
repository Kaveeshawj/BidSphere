package lk.jiat.ee.web.servlet;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import model.UserStore;

import java.io.IOException;

@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String mobile = request.getParameter("mobile");
        String email = request.getParameter("email");

        UserStore store = UserStore.getInstance();
        boolean success = store.addUser(username, password, email, mobile);

        if (success) {
            response.sendRedirect("signin.html");
        } else {
            response.getWriter().println("Username already exists. Try again.");
        }
    }
}
