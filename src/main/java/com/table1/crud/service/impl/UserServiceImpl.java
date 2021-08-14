package com.table1.crud.service.impl;

import com.table1.crud.repository.UserRepository;
import com.table1.crud.entity.User;
import com.table1.crud.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * @author zengwenxing
 * @date 2021/8/11 - 18:50
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;
    @Override
    public List<User> getAllUsers() {
        return userRepository.getAll();
    }

    @Override
    public Long getTotal() {
        return userRepository.getTotal();
    }

    @Override
    public List<User> findUsers(Map<String, Object> map) {
        return userRepository.find(map);
    }

    @Override
    public String addUser(User user) {
        return userRepository.save(user);
    }

    @Override
    public void updateUser(User user) {
        userRepository.saveOrUpdate(user);
    }

    @Override
    public void deleteUser(String uuid) {
        userRepository.delete(uuid);
    }
}
