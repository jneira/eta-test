import eta_test.Lib;
import java.util.function.Consumer;
public class JParse {

    public static void main(String args[]) throws Exception {
        System.out.println("======== RUNNING  ===============");
        Lib.jparse("", str -> System.out.println("Error: "+str),
                   str -> System.out.println("Ok: "+str));
        Lib.jparse("string", str -> System.out.println("Error: "+str),
                   str -> System.out.println("Ok: "+str));
        System.out.println("=================================");
    }

}
