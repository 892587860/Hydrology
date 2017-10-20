package com.hydro.mapper;

import java.util.List;

import com.hydro.model.UserInfo;

public interface UserInfoMapper {
	
	List<UserInfo> findAll();
	
    int deleteByPrimaryKey(Integer userId);

    int insert(UserInfo record);

    int insertSelective(UserInfo record);

    UserInfo selectByPrimaryKey(Integer userId);

    int updateByPrimaryKeySelective(UserInfo record);

    int updateByPrimaryKey(UserInfo record);
}