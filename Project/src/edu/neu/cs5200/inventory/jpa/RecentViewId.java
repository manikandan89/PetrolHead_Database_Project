package edu.neu.cs5200.inventory.jpa;

import java.io.Serializable;


public class RecentViewId implements Serializable {
	
	private long personId;
	private long styleId;
	
	  public int hashCode() {
		    return (int)(personId + styleId);
		  }
		 
		  public boolean equals(Object object) {
		    if (object instanceof RecentViewId) {
		    	RecentViewId otherId = (RecentViewId) object;
		      return (otherId.personId == this.personId) && (otherId.styleId == this.styleId);
		    }
		    return false;
		  }

}
