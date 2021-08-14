package com.table1.crud.service;

import com.table1.crud.entity.User;

import java.util.List;
import java.util.Map;

/**
 * @author zengwenxing
 * @date 2021/8/9 - 22:03
 */
public interface UserService {

    public List<User> getAllUsers();

    public Long getTotal();

    public List<User> findUsers(Map<String, Object> map);

    public String addUser(User user);

    public void updateUser(User user);

    public void deleteUser(String uuid);
}
