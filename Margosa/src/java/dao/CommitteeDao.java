package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Committee;

public class CommitteeDao {

    private Connection con;
    private String query;
    private PreparedStatement pst;
    private ResultSet rs;

    public CommitteeDao(Connection con) {
        this.con = con;
    }

    public Committee committeeLogin(String username, String password) {
        Committee committee = null;
        try {
            query = "SELECT * FROM Committee WHERE USERNAME=? AND PASSWORD=?";
            pst = con.prepareStatement(query);
            pst.setString(1, username);
            pst.setString(2, password);
            rs = pst.executeQuery();

            if (rs.next()) {
                committee = new Committee();
                committee.setComid(rs.getInt("COMID"));
                committee.setUsername(rs.getString("USERNAME"));
                committee.setPassword(rs.getString("PASSWORD"));
                committee.setName(rs.getString("NAME"));
                committee.setEmail(rs.getString("EMAIL"));
                committee.setPhoneNum(rs.getString("PHONE"));
                committee.setRole(rs.getString("ROLE"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return committee;
    }

    public void addCommittee(Committee committee) {
        try {
            query = "INSERT INTO Committee (USERNAME, PASSWORD, NAME, EMAIL, PHONE, ROLE) VALUES (?, ?, ?, ?, ?, ?)";
            pst = con.prepareStatement(query);
            pst.setString(1, committee.getUsername());
            pst.setString(2, committee.getPassword());
            pst.setString(3, committee.getName());
            pst.setString(4, committee.getEmail());
            pst.setString(5, committee.getPhoneNum());
            pst.setString(6, committee.getRole());

            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateCommittee(Committee committee) {
        try {
            query = "UPDATE Committee SET USERNAME = ?, PASSWORD = ?, NAME = ?, EMAIL = ?, PHONE = ?, ROLE = ? WHERE COMID = ?";
            pst = con.prepareStatement(query);
            pst.setString(1, committee.getUsername());
            pst.setString(2, committee.getPassword());
            pst.setString(3, committee.getName());
            pst.setString(4, committee.getEmail());
            pst.setString(5, committee.getPhoneNum());
            pst.setString(6, committee.getRole());
            pst.setInt(7, committee.getComid());

            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteCommittee(int comid) {
        try {
            query = "DELETE FROM Committee WHERE COMID = ?";
            pst = con.prepareStatement(query);
            pst.setInt(1, comid);

            pst.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Committee getCommitteeById(int comid) {
        Committee committee = null;
        try {
            query = "SELECT * FROM Committee WHERE COMID = ?";
            pst = con.prepareStatement(query);
            pst.setInt(1, comid);
            rs = pst.executeQuery();

            if (rs.next()) {
                committee = new Committee();
                committee.setComid(rs.getInt("COMID"));
                committee.setUsername(rs.getString("USERNAME"));
                committee.setPassword(rs.getString("PASSWORD"));
                committee.setName(rs.getString("NAME"));
                committee.setEmail(rs.getString("EMAIL"));
                committee.setPhoneNum(rs.getString("PHONE"));
                committee.setRole(rs.getString("ROLE"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return committee;
    }

    public List<Committee> getAllCommittees() {
        List<Committee> committeeList = new ArrayList<>();
        try {
            query = "SELECT * FROM Committee";
            pst = con.prepareStatement(query);
            rs = pst.executeQuery();

            while (rs.next()) {
                Committee committee = new Committee();
                committee.setComid(rs.getInt("COMID"));
                committee.setUsername(rs.getString("USERNAME"));
                committee.setPassword(rs.getString("PASSWORD"));
                committee.setName(rs.getString("NAME"));
                committee.setEmail(rs.getString("EMAIL"));
                committee.setPhoneNum(rs.getString("PHONE"));
                committee.setRole(rs.getString("ROLE"));

                committeeList.add(committee);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return committeeList;
    }
}
