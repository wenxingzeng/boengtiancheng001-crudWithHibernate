package com.table1.crud.repository.impl;

import com.table1.crud.repository.UserRepository;
import com.table1.crud.entity.User;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * @author zengwenxing
 * @date 2021/8/11 - 17:35
 */
@Repository
public class UserRepositoryImpl implements UserRepository {
    @Autowired
    private SessionFactory sessionFactory;

    private Session getCurrentSession() {
        return this.sessionFactory.openSession();
    }

    @Override
    public List<User> getAll() {
        SQLQuery query = getCurrentSession().createSQLQuery("SELECT * from table_1");
        query.addEntity(User.class);
        List<User> users = query.list();
        return users;
    }

    @Override
    public Long getTotal() {
        SQLQuery query = getCurrentSession().createSQLQuery("SELECT count(1) from table_1");
        String total = query.uniqueResult().toString();
        return Long.valueOf(total);
    }

    @Override
    public List<User> find(Map<String, Object> map) {
        String sql = "select column1, column2, LOWER(column3) column3, column4, column5, " +
                "UPPER(column6) column6, column7, column8, column9, createtime, updatetime " +
                "from table_1 where column2 like '" + map.get("name") + "' and column4 like '" +
                map.get("gender") + "' and column8 like '" + map.get("phoneNumber") + "' and column9 like '" +
                map.get("email") + "' order by createtime DESC limit "+map.get("start")+","+map.get("size");
        System.out.println(sql);
        SQLQuery query = getCurrentSession().createSQLQuery(sql);
        query.addEntity(User.class);
        List<User> users = query.list();
        return users;
    }

    public String save(User entity) {
        Session s = getCurrentSession();
        Transaction tx = s.beginTransaction();
        String back = (String) s.save(entity);
        tx.commit();
        s.close();
        return back;
    }

    public void saveOrUpdate(User entity) {
        Session s = getCurrentSession();
        Transaction tx = s.beginTransaction();
        s.saveOrUpdate(entity);
        tx.commit();
        s.close();
    }

    public void delete(String id) {
        Session s = getCurrentSession();
        User user = (User) s.get(User.class,id);
        Transaction tx = s.beginTransaction();
        s.delete(user);
        tx.commit();
        s.close();

    }
}
