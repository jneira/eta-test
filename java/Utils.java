import java.nio.ByteBuffer;
import eta.runtime.io.MemoryManager;

public class Utils {
    public static void trace(ByteBuffer buf,int offset, int length) {
        System.out.println("Ptr: "+buf);
        System.out.println("Offset: "+offset);
        System.out.println("Length: "+length);
    }

}
