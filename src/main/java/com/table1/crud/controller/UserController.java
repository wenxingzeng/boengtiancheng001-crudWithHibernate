package com.table1.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.table1.crud.entity.User;
import com.table1.crud.service.UserService;
import com.table1.crud.util.ResponseUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author zengwenxing
 * @date 2021/8/9 - 22:21
 */
@Controller
public class UserController {
    @Autowired
    private UserService userService;

    /*@InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));   //true:允许输入空值，false:不能为空值
    }*/

    @RequestMapping("/usersList")
    @ResponseBody
    public PageInfo getUsersWithJSON(@RequestParam(value="pn",defaultValue="1") Integer pn) {
        PageHelper.startPage(pn, 5);
        List<User> users = userService.getAllUsers();

        PageInfo page = new PageInfo(users,5);

        return page;
    }

    @RequestMapping("/findUsers")
    public String findUsers(@RequestParam(value="pn",defaultValue="1") Integer pn,
                       @RequestParam(value = "page", required = false) String page,
                       @RequestParam(value = "rows", required = false) String rows,
                       User user, HttpServletRequest request, HttpServletResponse response) throws IOException {

        Map<String, Object> map = new HashMap<String, Object>();

        String name = user.getColumn2();
        if(name!=null) {
            name = "%" + name + "%";
        } else {
            name = "%%";
        }
        String simpleName = user.getColumn3();
        String gender = user.getColumn4();
        if(gender!=null) {
            gender = "%" + gender + "%";
        } else {
            gender = "%%";
        }
        String idType = user.getColumn5();
        String idCard = user.getColumn6();
        Date birthday = user.getColumn7();
        String phoneNumber = user.getColumn8();
        if(phoneNumber!=null) {
            phoneNumber = "%" + phoneNumber + "%";
        } else {
            phoneNumber = "%%";
        }
        String email = user.getColumn9();
        if(email!=null) {
            email = "%" + email + "%";
        } else {
            email = "%%";
        }
        Date cteateTime = user.getCreatetime();
        Date updateTime = user.getUpdatetime();

        Integer start = (Integer.parseInt(page)-1)*Integer.parseInt(rows);
        Integer size = Integer.parseInt(rows);
        Long total = userService.getTotal();

        map.put("name", name);
        map.put("simpleName", simpleName);
        map.put("gender", gender);
        map.put("idType", idType);
        map.put("idCard", idCard);
        map.put("birthday", birthday);
        map.put("phoneNumber", phoneNumber);
        map.put("email", email);
        map.put("cteateTime", cteateTime);
        map.put("updateTime", updateTime);
        map.put("start", start);
        map.put("size", size);

        List<User> users = userService.findUsers(map);

        JSONObject result = new JSONObject();
        JSONArray jsonArray = JSONArray.fromObject(users);
        result.put("rows", jsonArray);
        result.put("total", total);
        ResponseUtil.write(response, result);

        return null;
    }

    @ResponseBody
    @RequestMapping(value = "/userSave")
    public Object save(@Valid User user, HttpServletResponse response, BindingResult bs) throws Exception {

        if(bs.getErrorCount()>0){
            System.out.println("出错了!");
            for(FieldError error:bs.getFieldErrors()){
                System.out.println(error.getField()+":"+error.getDefaultMessage());
                return error.getField()+":"+error.getDefaultMessage();
            }
        }

        String column2 = user.getColumn2();
        String column3 = user.getColumn3();
        if(column2.equals("") || column3.equals("")) {
            JSONObject result = new JSONObject();
            result.put("errmsg", "姓名或姓名全拼不能为空格");
            return result;
            //return "姓名或姓名全拼不能为空格";
        }
        //System.out.println(column2);
        //System.out.println(column2.contains(" "));
        //System.out.println(column2.length());
        //System.out.println(column2.matches("^((?!\\s).)*$"));

        Boolean update = true;
        if(user.getColumn1() == null) {
            user.setColumn1(UUID.randomUUID().toString().replace("-",""));
            update = false;
        }
        if(user.getColumn6() != null) {
            user.setColumn6(user.getColumn6().toUpperCase());
        }
        user.setCreatetime(new Date());
        user.setUpdatetime(new Date());

        JSONObject result = new JSONObject();

        if (update) {
            userService.updateUser(user);
        } else {
             userService.addUser(user);
        }

        result.put("errres", true);
        result.put("errmsg", "数据保存成功！");

        ResponseUtil.write(response, result);
        return null;
    }

    @RequestMapping("/userDelete")
    public String delete(@RequestParam(value = "ids") String ids, HttpServletResponse response) throws Exception {
        JSONObject result = new JSONObject();
        String[] idsStr = ids.split(",");
        for (int i = 0; i < idsStr.length; i++) {
            userService.deleteUser(idsStr[i]);
        }
        result.put("errres", true);
        result.put("errmsg", "数据删除成功！");
        ResponseUtil.write(response, result);
        return null;
    }
}
