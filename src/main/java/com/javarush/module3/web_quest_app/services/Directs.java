package com.javarush.module3.web_quest_app.services;

import com.javarush.module3.web_quest_app.model.dependency.MyBean;
import jakarta.servlet.http.HttpServletRequest;

public class Directs {
    public static void getPathAttributes(HttpServletRequest req) {
        String keyFile = req.getParameter("key_file");
        String valueFile = req.getParameter("value_file");

        String includePath;
        MyBean myBean = MyBean.getInstance();
        if (keyFile != null && !keyFile.isEmpty() && valueFile != null && !valueFile.isEmpty()) {
            includePath = valueFile;
            myBean.addValue(keyFile, includePath);
        } else {
            includePath = "/WEB-INF/includes/main/start.jsp";
            keyFile = "includePath";
        }
        myBean.addValue(keyFile, includePath);
    }
}
