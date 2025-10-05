

/* This class implements a model of the behavior of a process. 
   To this end it assumes that a process always have a number
   of "hot spot". The locality of references is assured by the model
   in this way because it generate the next accessed reference by
   picking one hot spot randomly first. Then it computes the final
   logical address by adding a randomly chosen value to it which 
   has a predetermined average distance to 0.

   Since hot spots do change during the execution of a program,
   the model randomly changes a hotspot. In average after 
   1000 accesses a hot spot is changed.
 */
public class LocalPM extends ProcessModel {
 
    private int[] spots; 
    private int averageDist, numberOfSpots;
    
    // getting all relevant values for the model by the constructor
    public LocalPM (int size, int nrOfSpots, int averageDistance) {
	super(size);
	spots = new int[nrOfSpots]; 
	averageDist = averageDistance;
	numberOfSpots = nrOfSpots;

	for (int i=0; i<nrOfSpots; i++) { // choose the initial hot spots
	    spots[i] = myRnd.nextInt(size); 
	}
    }
    

    public int getNextAccess()
    {   
	// pick a hot spot randomly
	int spot = myRnd.nextInt(numberOfSpots);

	// exchange it by a new hot spot (from time to time only)
	if (myRnd.nextInt(10000)<10) { // probability of 0.1 percent that a spot is changed
	    spots[spot] = myRnd.nextInt(size); 
	}

	// now pick a distance 
	int distance = myRnd.nextInt(averageDist*4)-2*averageDist;
	int address = (spots[spot]+distance+size)%size; // the final (logical) address
	return address;
    }
}