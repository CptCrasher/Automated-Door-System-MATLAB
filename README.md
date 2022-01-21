# Automated Door Opening System
 
The Automated Door Opening System is a major project created in MATLAB for 
a first year Engineering Course.
 
### Context
In my first year 'Computational Thinking through Mechatronics' course,
the class was tasked with creating any project we liked as long as it hard a physical
hardware component (Arduino) and it was programmed using MATLAB.
 
During the time, COVID was near its peak during the second wave which 
inspired me to create some sort of system (or prototype of a system) 
that could help a group of people affected by the current impacts of the
virus in our communities.
 
While trying to stay within the scope of our assignment and time allocated to 
us, I decided to create prototype of a door opening system allowing users
to open a door simply by waving their hand in front of it resulting in a reduced amount of  germs
being spread by people touching a door handle.
 
Having come up with this idea, I implemented other safety features such as:
* Detecting when an object or person is blocking the door so it doesn't close on them
* Light & sound indicators that tell you the state of the system
* A 'night-mode' that disables access to the door when it becomes dark
 
### About the project
Utilizing the 'MATLAB Support Package for Arduino Hardware', both digital
and analog voltage signals can be sent to specific input pins of an Arduino board.
 
Being able to turn pins on and off in MATLAB allows for the implementation
of MATLAB's math based functionality in Arduino systems that would typically
be created in the Arduino IDE.
 
### How it Works
#### The components used in this project are as follows:
* `An Arduino Groove Board`
* `Servo Motor`
* `PIR Motion Sensor`
* `Ultrasonic Sound Sensor`
* `Photoresistor`
* `Piezo Buzzer`
* `Colored LEDs x2`
* `Push Button`
* `Bread Board`
 
The servo would be attached to a door (or place holder object acting as door) which rotates in a 90 degree motion.
On the backside of the same object, the ultrasonic sensor is placed, and is used to check 
if an object is the door's closing path. The motion sensor would be placed at the front of the door to 
detect motion, the LDR is placed outside of the door to detect lighting levels and other components are placed near the door (with LEDs being visible) 
to be connected to a breadboard that connects everything to the Arduino.
 
When the program is launched, the system is always checking to make sure it is day time (using the LDR).
If so, the rest of the system works and a green led indicates that it is daytime. We then always check for an input signal from the PIR motion sensor.
If there is a signal, the servo is then turned on to open a door, the red LED turns on and a 'chime' plays on the buzzer. After a couple of seconds
the door is then rotated back using the servo along with the chime played in reverse unless the ultrasonic sound sensor detects an object that is close to the backside of the door.
If there is an object near the door, the servo doesn't close the door. Instead a red light begins flashing with a repeated beeping played by the buzzer (telling you something is blocking the door).
If the button is pressed, everything turns off and the system is terminated.
