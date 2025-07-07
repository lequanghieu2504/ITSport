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
    private final String GET_ALL = "select * from Brand ";
    public List<BrandDTO> getAllBrand(){
        String sql = GET_ALL;
        List<BrandDTO> listB = new ArrayList<>();
        try(Connection conn = JDBCConnection.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)){
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                BrandDTO brandDTO = BrandMapper.toBrandDTOFromResultSet(rs);
                listB.add(brandDTO);
            }
            return listB;
        } catch (SQLException ex) {
            Logger.getLogger(BrandDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
    
}
