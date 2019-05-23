import com.google.common.hash.Hashing;
import java.nio.charset.Charset;

/**
 * Md5Test
 *
 * @date 2019/3/8 16:56
 */
public class Md5Test {
    public static void main(String[] args) {
        System.out.println(Hashing.md5().hashString("zhangxh_salt_1", Charset.forName("utf-8")));
    }
}
