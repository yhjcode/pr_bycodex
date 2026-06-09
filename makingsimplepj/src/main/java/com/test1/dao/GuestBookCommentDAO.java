package com.test1.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.test1.dto.GuestBookCommentDTO;

public class GuestBookCommentDAO {
    private static final GuestBookCommentDAO instance = new GuestBookCommentDAO();

    private static final String DRIVER = "oracle.jdbc.OracleDriver";
    private static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    private static final String DB_USER = "test1";
    private static final String DB_PASSWORD = "1234";

    private GuestBookCommentDAO() {
        try {
            Class.forName(DRIVER);
        } catch (ClassNotFoundException e) {
            throw new IllegalStateException("Oracle JDBC Driver not found.", e);
        }
    }

    public static GuestBookCommentDAO getInstance() {
        return instance;
    }

    private Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, DB_USER, DB_PASSWORD);
    }

    public List<GuestBookCommentDTO> getListByContentIdx(int contentIdx) {
        List<GuestBookCommentDTO> list = new ArrayList<>();
        String sql = "SELECT comment_idx, content_idx, writer, content, reg_date "
                + "FROM content_comments WHERE content_idx = ? ORDER BY comment_idx ASC";

        try (Connection conn = getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, contentIdx);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    GuestBookCommentDTO dto = new GuestBookCommentDTO();
                    dto.setCommentIdx(rs.getInt("comment_idx"));
                    dto.setContentIdx(rs.getInt("content_idx"));
                    dto.setWriter(rs.getString("writer"));
                    dto.setContent(rs.getString("content"));
                    dto.setRegDate(rs.getTimestamp("reg_date"));
                    list.add(dto);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Failed to select comments.", e);
        }

        return list;
    }

    public int insert(GuestBookCommentDTO dto) {
        String sql = "INSERT INTO content_comments (comment_idx, content_idx, writer, content) "
                + "VALUES (content_comments_seq.NEXTVAL, ?, ?, ?)";

        try (Connection conn = getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, dto.getContentIdx());
            pstmt.setString(2, dto.getWriter());
            pstmt.setString(3, dto.getContent());
            return pstmt.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException("Failed to insert comment.", e);
        }
    }
}
