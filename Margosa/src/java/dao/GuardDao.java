package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Guard;

public class GuardDao {

    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public GuardDao(Connection con) {
        this.con = con;
    }

    public Guard guardLogin(String username, String password) {
        Guard guard = null;
        try {
            query = "SELECT * FROM Guard WHERE USERNAME=? AND PASSWORD=?";
            pst = con.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, password);
            rs = pst.executeQuery();

            if (rs.next()) {
                guard = new Guard();
                guard.setGid(rs.getInt("GID"));
                guard.setUsername(rs.getString("USERNAME"));
                guard.setPassword(rs.getString("PASSWORD"));
                guard.setName(rs.getString("NAME"));
                guard.setEmail(rs.getString("EMAIL"));
                guard.setPhoneNum(rs.getString("PHONE"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return guard;
    }

    public void addGuard(Guard guard) {
        try {
            query = "INSERT INTO Guard (USERNAME, PASSWORD, NAME, EMAIL, PHONE) VALUES (?, ?, ?, ?, ?)";
            pst = con.prepareStatement(query);
            pst.setString(1, guard.getUsername());
            pst.setString(2, guard.getPassword());
            pst.setString(3, guard.getName());
            pst.setString(4, guard.getEmail());
            pst.setString(5, guard.getPhoneNum());

            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateGuard(Guard guard) {
        try {
            query = "UPDATE Guard SET USERNAME = ?, PASSWORD = ?, NAME = ?, EMAIL = ?, PHONE = ? WHERE GID = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, guard.getUsername());
            pst.setString(2, guard.getPassword());
            pst.setString(3, guard.getName());
            pst.setString(4, guard.getEmail());
            pst.setString(5, guard.getPhoneNum());
            pst.setInt(6, guard.getGid());

            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteGuard(int gid) {
        try {
            query = "DELETE FROM Guard WHERE GID = ?";
            pst = con.prepareStatement(query);
            pst.setInt(1, gid);

            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Guard getGuardById(int gid) {
        Guard guard = null;
        try {
            query = "SELECT * FROM Guard WHERE GID = ?";
            pst = con.prepareStatement(query);
            pst.setInt(1, gid);
            rs = pst.executeQuery();

            if (rs.next()) {
                guard = new Guard();
                guard.setGid(rs.getInt("GID"));
                guard.setUsername(rs.getString("USERNAME"));
                guard.setPassword(rs.getString("PASSWORD"));
                guard.setName(rs.getString("NAME"));
                guard.setEmail(rs.getString("EMAIL"));
                guard.setPhoneNum(rs.getString("PHONE"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return guard;
    }

    public List<Guard> getAllGuards() {
        List<Guard> guardList = new ArrayList<>();
        try {
            query = "SELECT * FROM Guard";
            pst = con.prepareStatement(query);
            rs = pst.executeQuery();

            while (rs.next()) {
                Guard guard = new Guard();
                guard.setGid(rs.getInt("GID"));
                guard.setUsername(rs.getString("USERNAME"));
                guard.setPassword(rs.getString("PASSWORD"));
                guard.setName(rs.getString("NAME"));
                guard.setEmail(rs.getString("EMAIL"));
                guard.setPhoneNum(rs.getString("PHONE"));

                guardList.add(guard);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return guardList;
    }
}
