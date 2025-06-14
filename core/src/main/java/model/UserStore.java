package model;

import java.util.HashMap;

public class UserStore {
    private static UserStore instance = null;
    private HashMap<String, User> users = new HashMap<>();

    private UserStore() {

    }

    public static UserStore getInstance() {
        if (instance == null) {
            instance = new UserStore();
        }
        return instance;
    }

    public boolean addUser(String username, String password, String email, String mobile) {
        if (users.containsKey(username)) return false;
        users.put(username, new User(username, password, email, mobile));
        return true;
    }

    public User getUser(String username) {
        return users.get(username);
    }
}
