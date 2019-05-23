package com.dlut.platform.util;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.core.convert.converter.Converter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DateConverterMVC implements Converter<String, Date> {
    private static Logger errLog = Logger.getLogger("errorLog");
    private static final List<String> FORMARTS = new ArrayList<>(4);

    static {
        FORMARTS.add("yyyy-MM");
        FORMARTS.add("yyyy-MM-dd");
        FORMARTS.add("yyyy-MM-dd hh:mm");
        FORMARTS.add("yyyy-MM-dd hh:mm:ss");
    }

    @Override
    public Date convert(String source) {
        source = source.trim();
        if(StringUtils.isBlank(source)) {
            return null;
        }
        if(source.matches("^\\d{4}-\\d{1,2}$")) {
            return parseDate(source, FORMARTS.get(0));
        }
        else if(source.matches("^\\d{4}-\\d{1,2}-\\d{1,2}$")) {
            return parseDate(source, FORMARTS.get(1));
        }
        else if(source.matches("^\\d{4}-\\d{1,2}-\\d{1,2} {1}\\d{1,2}:\\d{1,2}$")) {
            return parseDate(source, FORMARTS.get(2));
        }
        else if(source.matches("^\\d{4}-\\d{1,2}-\\d{1,2} {1}\\d{1,2}:\\d{1,2}:\\d{1,2}$")) {
            return parseDate(source, FORMARTS.get(3));
        }
        else {
            throw new IllegalArgumentException("Invalid boolean value '" + source + "'");
        }
    }

    public Date parseDate(String dateStr, String format) {
        Date date = null;
        try {
            DateFormat dateFormat = new SimpleDateFormat(format);
            date = dateFormat.parse(dateStr);
        }
        catch(Exception ex) {
            errLog.error(dateStr + " format " + format + " error.", ex);
        }
        return date;
    }
}
