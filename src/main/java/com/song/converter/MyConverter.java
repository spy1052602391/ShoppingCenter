package com.song.converter;

import org.apache.commons.beanutils.Converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 日期转换器 : 将表单中的String的日期，转换成Date日期类型
 */

public class MyConverter implements Converter {
    /**
     *
     * @param aClass  : 需要被转换的类型为什么类型
     * @param o   :  需要转换对象是什么。
     * @return
     */
    @Override
    public Object convert(Class aClass, Object o) {
        //需要将String ---->  Date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        try {

            Date date = sdf.parse((String)o);

            return date;
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }
}
