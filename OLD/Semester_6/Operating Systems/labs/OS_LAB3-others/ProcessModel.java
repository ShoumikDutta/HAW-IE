

import java.util.Random;


public abstract class ProcessModel {
    protected final int VMSIZE     = VMConstants.VMSIZE;
    protected int size;  //size of required memory. 

    static public Random myRnd = new Random();
 
    public ProcessModel (int size) {
	this.size = size;
 	myRnd.setSeed(4711); // do not change this seed!
   } ;
    
    // here one can implement a new model for the behavior of a process. 
    public abstract int getNextAccess();
}