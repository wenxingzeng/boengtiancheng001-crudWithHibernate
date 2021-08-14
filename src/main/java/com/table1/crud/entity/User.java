package com.table1.crud.entity;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;
import javax.validation.constraints.Pattern;
import java.util.Date;

@Entity
@Table(name = "table_1")
public class User {
    @Id
    private String column1;

    @NotNull
    //@NotEmpty
    @Pattern(regexp = "^((?!\\s).)*$")
    @Column(name = "column2")
    private String column2;

    @NotNull
    //@NotEmpty
    @Pattern(regexp = "^((?!\\s).)*$")
    @Column(name = "column3")
    private String column3;

    @NotNull
    @Pattern(regexp = "[男女]")
    @Column(name = "column4")
    private String column4;

    @NotNull
    @Pattern(regexp = "[居][民][身][份][证]|[士][官][证]|[学][生][证]|[驾][驶][证]|[护][照]|[港][澳][通][行][证]")
    @Column(name = "column5")
    private String column5;

    @NotNull
    @Pattern(regexp = "(^\\d{18}$)|(^\\d{17}(\\d|X|x)$)")
    @Column(name = "column6")
    protected String column6;

    @NotNull
    @Past
    @Column(name = "column7")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date column7;

    @NotNull
    @Pattern(regexp = "^(((13[0-9]{1})|(15[0-9]{1})|(16[0-9]{1})|(17[3-8]{1})|(18[0-9]{1})|(19[0-9]{1})|(14[5-7]{1}))+\\d{8})$")
    @Column(name = "column8")
    private String column8;

    @NotNull
    @NotEmpty
    @Email
    @Column(name = "column9")
    private String column9;

    @Column(name = "createtime")
    private Date createtime;

    @Column(name = "updatetime")
    private Date updatetime;

    public User() {
        super();
    }

    public User(String column1, String column2, String column3, String column4, String column5, String column6, Date column7, String column8, String column9, Date createtime, Date updatetime) {
        this.column1 = column1;
        this.column2 = column2;
        this.column3 = column3;
        this.column4 = column4;
        this.column5 = column5;
        this.column6 = column6;
        this.column7 = column7;
        this.column8 = column8;
        this.column9 = column9;
        this.createtime = createtime;
        this.updatetime = updatetime;
    }

    public String getColumn1() {
        return column1;
    }

    public void setColumn1(String column1) {
        this.column1 = column1 == null ? null : column1.trim();
    }

    public String getColumn2() {
        return column2;
    }

    public void setColumn2(String column2) {
        this.column2 = column2 == null ? null : column2.trim();
    }

    public String getColumn3() {
        return column3;
    }

    public void setColumn3(String column3) {
        this.column3 = column3 == null ? null : column3.trim();
    }

    public String getColumn4() {
        return column4;
    }

    public void setColumn4(String column4) {
        this.column4 = column4 == null ? null : column4.trim();
    }

    public String getColumn5() {
        return column5;
    }

    public void setColumn5(String column5) {
        this.column5 = column5 == null ? null : column5.trim();
    }

    public String getColumn6() {
        return column6;
    }

    public void setColumn6(String column6) {
        this.column6 = column6 == null ? null : column6.trim();
    }

    public Date getColumn7() {
        return column7;
    }

    public void setColumn7(Date column7) {
        this.column7 = column7;
    }

    public String getColumn8() {
        return column8;
    }

    public void setColumn8(String column8) {
        this.column8 = column8 == null ? null : column8.trim();
    }

    public String getColumn9() {
        return column9;
    }

    public void setColumn9(String column9) {
        this.column9 = column9 == null ? null : column9.trim();
    }

    public Date getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public Date getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(Date updatetime) {
        this.updatetime = updatetime;
    }

    @Override
    public String toString() {
        return "User{" +
                "column1='" + column1 + '\'' +
                ", column2='" + column2 + '\'' +
                ", column3='" + column3 + '\'' +
                ", column4='" + column4 + '\'' +
                ", column5='" + column5 + '\'' +
                ", column6='" + column6 + '\'' +
                ", column7=" + column7 +
                ", column8='" + column8 + '\'' +
                ", column9='" + column9 + '\'' +
                ", createtime=" + createtime +
                ", updatetime=" + updatetime +
                '}';
    }
}