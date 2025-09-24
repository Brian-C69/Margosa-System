package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Admin;

public class AdminDao {
    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public AdminDao(Connection con) {
        this.con = con;
    }
    
    public Admin adminLogin(String username, String password) {
        Admin admin = null;
        try {
            query = "SELECT * FROM Admin WHERE username=? AND password=?";
            pst = this.con.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, password);
            rs = pst.executeQuery();

            if (rs.next()) {
                admin = new Admin();
                admin.setAid(rs.getInt("AID"));
                admin.setUsername(rs.getString("USERNAME"));
                admin.setPassword(rs.getString("PASSWORD"));
                admin.setName(rs.getString("NAME"));
            }
        } catch (Exception e) {
            e.printStackTrace();
            System.out.print(e.getMessage());
        }
        return admin;
    }
    
}
