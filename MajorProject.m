%clear and close all to clean program
clear all; close all;

%Creating arduino object
a = arduino('COM4','uno','Libraries',{'Ultrasonic','Servo'});


%Creating Servo + Ultrasonic Sound Sensor Objects
u = ultrasonic(a,'D2','D4');
s = servo(a,'D8');

%Initializing Pin Variables
pir = 'D7';
greenLED = 'D13';
redLED = 'D12';
LDR = 'A1';
piezo = 'D11';
button = 'D6';

%Variables for future use
looper = 1;
pirValue = 0;
LDRValue = 0;
stop = false;

%Setting Servo to default position
writePosition(s,0);

%Pause before program begins
pause(2);

%While loop that allows the system to work continuously 
while ~stop
    
    %If there is enough light, green LED is turned on and code proceeds
    LDRValue = readVoltage(a,LDR);
    if LDRValue > 0.0650
        writeDigitalPin(a,greenLED,1);
        writeDigitalPin(a,redLED,0);
        pause(1);
        
        %If the motion sensor detects movement, buzzer plays and servo
        %moves
        
        pirValue = readDigitalPin(a,pir);
        if pirValue == 1
            pause(2);
            playTone(a,piezo,1200,0.3);
            pause(0.3);
            playTone(a,piezo,1600,0.3);
            pause(0.3);
            playTone(a,piezo,2100,0.3);
            pause(0.3);
            for i=0:0.005:0.5
                writePosition(s,i);
            end

             pause(5);

             %If the ultrasonic sound sensor calculates a distance between
             %an object and itself that is too small, buzzer and red LED
             %turn on until this distance becomes large
             distance = readDistance(u);

             while looper == 1 
                 if distance <=0.08
                     writeDigitalPin(a,redLED,1);
                     writeDigitalPin(a,greenLED,0);
                     playTone(a,piezo,1300,1);
                     pause(1);
                     playTone(a,piezo,1300,1);
                     pause(1);
                     playTone(a,piezo,1300,1);
                     pause(1);
                     %obtain distance again
                     distance = readDistance(u);
                 else 
                     %Once the loop is broken and a large enough distance
                     %is detected, the green LED is turned on again
                     looper = 0;
                     writeDigitalPin(a,redLED,0);
                     writeDigitalPin(a,greenLED,1);
                 end 
             end 
             %set back the loop variable
             looper = 1;
             
           %Buzzer is played and servo's position is moved to intial point 
            playTone(a,piezo,2100,0.3);
            pause(0.3);
            playTone(a,piezo,1600,0.3);
            pause(0.3);
            playTone(a,piezo,1200,0.3);
            pause(0.3);  
           for ii=0.5:-0.005:0
               writePosition(s,ii);
           end
           
        %Reset if condition
          pirValue = 0;

        %If the button is pressed, the main loop is broken 
        elseif readDigitalPin(a,button) == 1
            stop = true;
            pause(1);
        end
        
    else 
        %If the LDR determines that it is too dark, the red LED is turned
        %on
        writeDigitalPin(a,redLED,1);
        writeDigitalPin(a,greenLED,0);
        pause(1);
    
    end 
    
end
        %Once the loop is broken through the button, both LEDs are turned
        %off and the buzzer is turned on
writeDigitalPin(a,redLED,0);
writeDigitalPin(a,greenLED,0);
      for i=2400:-10:1700
          playTone(a,piezo,i,0.05);
          pause(0.05);
      end 
playTone(a,piezo,2000,1);
pause(1);
%End of program
        