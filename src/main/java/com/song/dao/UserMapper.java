package com.song.dao;

import com.song.domain.User;

public interface UserMapper {

    User queryUserByName(User user) throws Exception;

    void add(User user) throws Exception;

    User findByUsernameAndPassword(User user) throws Exception ;

}
