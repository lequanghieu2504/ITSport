/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DTOs.BrandDTO;
import Mapper.BrandMapper;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import util.JDBCConnection;

/**
 *
 * @author ASUS
 */
public class BrandDAO {

    private static final String GET_ALL_BRAND = "SELECT * FROM Brand";

    public List<BrandDTO> getAllBrand() {
        List<BrandDTO> listB = new ArrayList<>();
        try ( Connection conn = JDBCConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(GET_ALL_BRAND)) {
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BrandDTO brandDTO = BrandMapper.toBrandDTOFromResultSet(rs);
                listB.add(brandDTO);
            }
            return listB;
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        BrandDAO dao = new BrandDAO();
        List<BrandDTO> list = dao.getAllBrand();
        for (BrandDTO brandDTO : list) {
            System.out.println(brandDTO);
        }
    }
}
