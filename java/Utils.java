import java.nio.ByteBuffer;
import eta.runtime.io.MemoryManager;

public class Utils {
    public static void trace(ByteBuffer buf,int offset, int length) {
        System.out.println("Ptr: "+buf);
        System.out.println("Offset: "+offset);
        System.out.println("Length: "+length);
    }

    public static void testEmptyBuffer () {
        System.out.println("Testing allocate an empty buffer with MemoryManager");
        byte[] bytes = new byte[] {};
        long address = MemoryManager.allocateBuffer(bytes.length,false);
        System.out.println("Address: "+address);
        ByteBuffer buf = MemoryManager.getBoundedBuffer(address);
        System.out.println("Bounded Buffer: "+buf);
    }

}
