import com.dlut.platform.controller.IndexController;
import com.dlut.platform.domain.enumVo.USER_ENUM;
import com.dlut.platform.util.GsonUtil;
import org.springframework.jmx.export.assembler.MethodNameBasedMBeanInfoAssembler;

/**
 * EnumTest
 *
 * @date 2019/3/9 14:54
 */
public class EnumTest {
    public static void main(String[] args) {
        String json = GsonUtil.toEnumJson(USER_ENUM.FORBIDDEN_LOGIN);
        System.out.println(json);
        System.out.println("enum_adsas".substring("enum_".length()));
    }
}
