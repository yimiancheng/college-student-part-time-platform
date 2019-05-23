package com.dlut.platform.interceptor.annotation;

import com.dlut.platform.domain.enumVo.USER_ENUM;
import java.lang.annotation.*;
import static java.lang.annotation.ElementType.TYPE;
import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.ElementType.METHOD;

/**
 * Permission
 *
 * @date 2019/3/9 18:12
 */
@Target({TYPE, FIELD, METHOD})
@Retention(RetentionPolicy.RUNTIME)
@Inherited
@Documented
public @interface Permission {
    String value() default "STUDENT";
}
