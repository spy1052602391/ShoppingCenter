package com.song.service;

import com.song.domain.User;

/**
 * 用户的业务接口层
 */

public interface UserService {

    void regist(User user) throws Exception;

    public int checkUserName(String username) throws Exception;

    public int findByUsernameAndPassword(String username,String password)throws Exception ;

    User findUserByName(String username) throws Exception;

}
