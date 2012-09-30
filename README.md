Project 1: Web Analytics
========================

Full problem description is located at:
https://stellar.mit.edu/S/course/6/fa12/6.170/courseMaterial/topics/topic2/project/text1/text


###Code Deliverables

Your code should be a rails project located at the root of this repository. To
create a new rails project, run

    >> rails new .

in this directory.


###PDF Deliverables

Additional deliverables, such as the problem-analysis and the design-analysis, should
be saved as PDF files in the directory called "deliverables"

--------------------------------------------------------------

Here's the location right now:
http://fast-forest-5811.herokuapp.com/sites

What you're looking at:
The /sites summary page gives each site by its unique ID (Name). Next to the ID is the hit count (number of individual visits to a page), and the Duration (amount of time in seconds that users have spent on this site).

To view the summary page for any given site, view the page:
/sites/ID

E.G.:
http://fast-forest-5811.herokuapp.com/sites/1/
http://fast-forest-5811.herokuapp.com/sites/285/

This summary page shows the total number of hits and the total amount of time that users have spent looking at this page. The second table shows the hits and view durations for each page within the site ID given.

The Javascript snipped to be inserted to any client page is here:

<script language="JavaScript" src="http://www.geoplugin.net/javascript.gp" type="text/javascript"></script>
<script type="text/javascript">
      var time_start;
      var my_id = XXXXXXXXX;
      window.onload = function() {
            time_start = new Date().getTime();
      }

      window.onunload = function() {
            ping(new Date().getTime() - time_start);
      }

      function ping(difference) {
            var xhr = new XMLHttpRequest();

      	    xhr.onreadystatechange = function() {
	            if (xhr.readyState == 1) {
		       console.log("The call to open(...) succeeded.");
	            }
		    if (xhr.readyState == 2) {
          	       console.log("The call to send(...) succeeded. Waiting for response...");
		    }
		    if (xhr.readyState == 3) {
		       console.log("The response is coming in!!");
		    }
		    if (xhr.readyState == 4) {
		       console.log("The call to open(...) succeeded.We now have the complete response: " + xhr.response);
        	    }
            }
               var url = window.location.pathname;
	       xhr.open("GET", "http://fast-forest-5811.herokuapp.com/sites/"+my_id+"/"+url+"/"+difference/1000+"/" + new Date().getHours() + "/" + geoplugin_city(), false);
	       xhr.send("");
      }
</script>

The client *must* change the variable "my_id" to the unique identifier given to them by system administrators running the web analytics server.

I also just looked at this README in the browser and it looks disgusting. Sorry about that. The txt file by itself looks pretty nice. One final note is that there's a sample website using the javascript injected code at the root directory called: Test_Page.html.

Features include:
	- Login and logout
	- geolocations for site visitors
	- number of visitors by hour of the day (i.e., how many users sign on at 5pm vs the global average?)