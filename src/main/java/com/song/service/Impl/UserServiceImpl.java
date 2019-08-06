package com.song.service.Impl;


import com.song.dao.UserMapper;
import com.song.domain.User;
import com.song.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

/**
 * 用户的业务实现层
 */

public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;

    @Override
    public void regist(User user) throws Exception {

        userMapper.add(user);

    }

    @Override
    public int findByUsernameAndPassword(String username, String password) throws Exception {
        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        User user1 = userMapper.findByUsernameAndPassword(user);
        int result = 0;
        if(user1 != null){
            if(user1.getPassword().equals(password)){
                result = 1;
            }else{
                result = -1;
            }
        }
        return result;
    }

    @Override
    public User findUserByName(String username) throws Exception {
        User user = new User();
        user.setUsername(username);
        return userMapper.queryUserByName(user);
    }

    @Override
    public int checkUserName(String username) throws Exception {
        User user = new User();
        user.setUsername(username);

        User user1 = userMapper.queryUserByName(user);

        int result = 1;

        if(user1 == null)
            result = 0;

        return result;
    }

}
