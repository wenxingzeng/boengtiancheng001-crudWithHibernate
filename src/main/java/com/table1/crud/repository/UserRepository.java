package com.table1.crud.repository;

import com.table1.crud.entity.User;

import java.util.List;
import java.util.Map;

/**
 * @author zengwenxing
 * @date 2021/8/11 - 17:29
 */
public interface UserRepository {
    public List<User> getAll();

    public Long getTotal();

    public List<User> find(Map<String, Object> map);

    public String save(User user);

    public void saveOrUpdate(User user);

    public void delete(String uuid);
}
