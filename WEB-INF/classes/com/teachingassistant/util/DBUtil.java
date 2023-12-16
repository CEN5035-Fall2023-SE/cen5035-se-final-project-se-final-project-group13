package com.teachingassistant.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

public class DBUtil {

	public static Properties properties = null;

	public static void loadProperties(Properties propertiesWihData) {
		properties = propertiesWihData;
	}

	public static Connection getConnection() {
		Connection connection = null;
		try {
			Class.forName(properties.getProperty("db.driver.class.name"));
			connection = DriverManager.getConnection(properties.getProperty("db.jdbc.url"),
					properties.getProperty("db.username"), properties.getProperty("db.pwd"));

		} catch (Exception e) {
			e.printStackTrace();
		}
		return connection;
	}

	public static void closeConnection(Connection connection) {
		if (connection != null) {
			try {
				connection.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public static void closeResultSet(ResultSet resultSet) {
		if (resultSet != null) {
			try {
				resultSet.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}

	public static void closePreparedStatement(PreparedStatement pstmt) {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
//	private static HikariConfig config = new HikariConfig();
//	public static HikariDataSource hikariDataSource;

//	public static Properties properties = null;

//	properties = propertiesWithData;
//	public static void createHikariDataSource(Properties propertiesWithData) {
//	config.setDriverClassName(properties.getProperty("db.driver.class.name"));
//	config.setJdbcUrl(properties.getProperty("db.jdbc.url"));
//	config.setUsername(properties.getProperty("db.username"));
//	config.setPassword(properties.getProperty("db.pwd"));
//	config.setMaximumPoolSize(Integer.parseInt(properties.getProperty("db.hikari.max.pool.size")));
//	config.setMinimumIdle(Integer.parseInt(properties.getProperty("db.hikari.min.idle.time")));
//	config.setIdleTimeout(Integer.parseInt(properties.getProperty("db.hikari.idle.timeout")));
//	config.setMaxLifetime(Integer.parseInt(properties.getProperty("db.hikari.max.lifetime")));
//	config.setPoolName(properties.getProperty("db.hikari.pool.name"));
//
//	hikariDataSource = new HikariDataSource(config);

}
