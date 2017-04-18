import java.nio.ByteBuffer;

public class Utils {
    public static void trace(ByteBuffer buf,int offset, int length) {
        System.out.println("Ptr: "+buf);
        System.out.println("Ofset: "+offset);
        System.out.println("Length: "+length);
    }
}
