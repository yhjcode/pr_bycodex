package com.test1.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.test1.dto.GuestBookDTO;

public class GuestBookDAO {
    private static final GuestBookDAO instance = new GuestBookDAO();

    private static final String DRIVER = "oracle.jdbc.OracleDriver";
    private static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    private static final String DB_USER = "test1";
    private static final String DB_PASSWORD = "1234";

    private GuestBookDAO() {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            throw new IllegalStateException("Oracle JDBC Driver not found.", e);
        }
    }

    public static GuestBookDAO getInstance() {
        return instance;
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, DB_USER, DB_PASSWORD);
    }

    // Select all posts. Sequence-generated idx values are sorted newest first.
    public List<GuestBookDTO> getList() {
        List<GuestBookDTO> list = new ArrayList<>();
        String sql = "SELECT idx, writer, title, content, reg_date, read_count "
                + "FROM contents ORDER BY idx DESC";

        try (Connection conn = getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql);
                ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                GuestBookDTO dto = new GuestBookDTO();
                dto.setIdx(rs.getInt("idx"));
                dto.setWriter(rs.getString("writer"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setRegDate(rs.getTimestamp("reg_date"));
                dto.setReadCount(rs.getInt("read_count"));
                list.add(dto);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to select guestbook list.", e);
        }

        return list;
    }

    // Increase read count for a post.
    public int increaseReadCount(int idx) {
        String sql = "UPDATE contents SET read_count = read_count + 1 WHERE idx = ?";

        try (Connection conn = getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, idx);
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to increase read count.", e);
        }
    }

    // Insert a post using the Oracle sequence for the primary key.
    public int insert(GuestBookDTO dto) {
        String sql = "INSERT INTO contents (idx, writer, title, content) "
                + "VALUES (contents_seq.NEXTVAL, ?, ?, ?)";

        try (Connection conn = getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, dto.getWriter());
            pstmt.setString(2, dto.getTitle());
            pstmt.setString(3, dto.getContent());
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to insert guestbook content.", e);
        }
    }
}
