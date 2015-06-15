%% Music Perception and Imagery Study 14/10/2014
% All information is read in from the music.mat file which should be in the
% same directory as this script.
% All information is saved in a two column structure in EEG_data
% Block 1 - music, cued imagination and uncued imagination are presented together for each song. Songs are randomized. 
% Block 2 - uncued imagination for each song. Songs are randomized
%
%
% Trigger values sent to Cedrus StimTracker:
% 0=
% 1= music
% 2= cued imagination
% 3= imagination without a cue
% 4= noise
% 5= 
% 6=
% 7=
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Initialize soundcard and load data
%%%%%%%%%% Setup soundcard for output %%%%%%%%%%
InitializePsychSound;
songhandle = PsychPortAudio('Open', [], [], 0, 44100, 2);
cuehandle = PsychPortAudio('Open', [], [], 0, 44100, 1);

%%%%%%%%% Open serial Port %%%%%%%%%
% define port
sport=serial('/dev/cu.usbserial-A703YW3J','BaudRate',115200);

%%%%%%%%% Load Data %%%%%%%%%%
Data = load('Scripts/music.mat'); %take file information from mat file

%%%%%%%%% Manual Input Variables %%%%%%%%%
commandwindow; 
test=input('Press 1 to open on this screen, Press 2 to open on secondary screen: '); %press 1 for debugging/testing
subID=input('Subject ID: ', 's');
subAge=input('Please enter the age of the participant: ', 's');
testStart=datestr(now,'yyyymmddTHHMMSSFFF');
n=input('Number of stimuli set repetitions for Block 1: ');
m=input('Number of stimuli set repetitions for Block 2: ');

%% Setup screen and messages  
%%%%%%%%% Screen Messages %%%%%%%%%
text{1}=['Thank you for your participating in this study. \n\n\n\n In a moment you will be asked to listen to and then imagine some music.\n\n '...
    'First you will be asked to listen to a piece of music. \n\n'...
    'Second you will be asked to imagine the same piece of music following a cue. \n\n ' ...
    'Third you will be asked to imagine the same piece of music with no cue. \n\n' ...
    'In between the different pieces of music you willl hear a short burst of white noise.'];
text{2}=['Some of the music you will hear has lyrics and some does not. \n\n'...
    'Please imagine the music in the same way it is presented to you. \n\n']; 
text{3}='The task will begin in...';
text{4}='3...';
text{5}='2...';
text{6}='1...';
text{7}=['You have now finished Block 1. Take a break before beginning Block 2 \n' ...
    'Press any key to continue.'];
text{8}=['While you are listening to and imagining the music you will see a small cross on the screen. \n\n' ...
    'Please keep your gaze on this cross as much as possible to minimize eye movements. \n\n' ...
    'Please stay as still as possible throughout the experiment'];
text{9}='Take a break. Press any key to continue.\n\n';
text{10}='Now you will see a practice trial so you know what to expect...';
text{11}=['Please ask the experimenter any questions you may have about the stimuli. \n\n' ...
    'Press any key to continue with the study'];
text{12}='The practice trial will begin in...';   
text{13}=['In this block you will be asked to imagine the same pieces as in the first block. \n\n'...
    'This Block will consist only of the imagery trials without the cue. \n\n'...
    'You will always begin imagining the piece of music at the presentation of the fixation cross.'];
text{14}=['At the end of each trial you will be asked to report whether you have performed the task correctly. \n\n' ...
    'If you feel you have imagined the music piece correctly please press the right button.\n\n' ...
    'If you feel you have imagined the music piece incorrectly please press the left button. \n\n' ...
    'Press any key to continue.'];
text{15}=['Do you feel you imagined the piece correctly? \n\n'...
    'No                                                Yes'];
text{16}=['The task has now ended \n\n' ...
    'Thank you for participating! \n\n' ...
    'Press any key to exit.'];   

countDown=[3 2 1];
 
black=[0,0,0];
white=[255,255,255];

if test == 1;
    [win, rect] = Screen('Openwindow', 0, black, [0,0,900,600]); % Open win in small box on primary screen.
else
    [win, rect] = Screen('Openwindow', 1, black); % Open win on secondary screen. [Primary screen is "0"]
end

Screen('TextSize', win, 18);

EEG_data=struct('type',{},'timestamp',{}); %initialize structure to save testing information
EEG_data=struct('type',{'subject ID'},'timestamp',{subID}); %save subject ID
EEG_data(end+1)=struct('type',{'subject age'},'timestamp',{subAge}); %save subject age
EEG_data(end+1)=struct('type',{'start time'},'timestamp',{datestr(now,'yyyymmddTHHMMSSFFF')}); %save start time of task


DrawFormattedText(win, text{1}, 'center', 'center', white); Screen('Flip', win);
KbWait([], 2);
DrawFormattedText(win, text{2}, 'center', 'center', white); Screen('Flip', win);
KbWait([], 2);
DrawFormattedText(win, text{8}, 'center', 'center', white); Screen('Flip', win);
KbWait([], 2);
%%%%%%%%% Fixation Cross Initialization %%%%%%%%%
[X,Y] = RectCenter(rect);
FixCross = [X-1,Y-20,X+1,Y+20;X-20,Y-1,X+20,Y+1];

%% Practice trial - Jingle Bells s
% No triggers sent during practice trials. 
% No file information saved during practice trials

%get name of song
song=Data.song{3};
%create instructions
text{17} = ['Please listen to \n\n'...
' ' song ' with lyrics \n\n'];
text{18} = ['Please imagine \n\n'...
' ' song ' with lyrics \n\n' ...
'following the cue'];
text{19} = ['Please imagine \n\n'...
' ' song ' with lyrics \n\n' ...
'when the fixation cross appears'];
msong=Data.musicfile{3}; %music.wav
cue=Data.cuefile{3}; %cue.wav
length=Data.length(3);

DrawFormattedText(win, text{10}, 'center', 'center', white); Screen('Flip', win);
WaitSecs(4);
DrawFormattedText(win, text{12}, 'center', 'center', white); Screen('Flip', win);
WaitSecs(2);
DrawFormattedText(win, text{4}, 'center', 'center', white); Screen('Flip', win);
WaitSecs(1);
DrawFormattedText(win, text{5}, 'center', 'center', white); Screen('Flip', win);
WaitSecs(1);
DrawFormattedText(win, text{6}, 'center', 'center', white); Screen('Flip', win);
WaitSecs(1);

%Practice trial - music perception
%instructions
DrawFormattedText(win, text{17}, 'center', 'center', white); Screen('Flip', win);
WaitSecs(4);
Screen('FillRect', win, white, FixCross'); Screen('Flip', win);
WaitSecs(1);

%play song
[bufferdata, freq] = audioread(msong);
bufferdata=bufferdata';
PsychPortAudio('FillBuffer', songhandle, bufferdata);
[~] = PsychPortAudio('Start', songhandle, 1, 0, 1);

status=PsychPortAudio('GetStatus', songhandle);
while status.Active ==1; % wait until stim is finished playing
    Screen('FillRect', win, black); % hold fixation cross while stim is playing
    Screen('FillRect', win, white, FixCross'); Screen('Flip', win);
    
    status=PsychPortAudio('GetStatus', songhandle);
    WaitSecs(0.5);
end

%Practice trial - Cued imagery
%instructions
DrawFormattedText(win, text{18}, 'center', 'center', white); Screen('Flip', win);
WaitSecs(4);
Screen('FillRect', win, white, FixCross'); Screen('Flip', win);
WaitSecs(1);

%play song
[bufferdata, freq] = audioread(cue);
bufferdata=bufferdata';
PsychPortAudio('FillBuffer', cuehandle, bufferdata);
[~] = PsychPortAudio('Start', cuehandle, 1, 0, 1);

status=PsychPortAudio('GetStatus', cuehandle);
WaitSecs(length+2);

%Practice trial - uncued imagery
%instructions + fixation cross
DrawFormattedText(win, text{19}, 'center', 'center', white); Screen('Flip', win);
WaitSecs(4);
Screen('FillRect', win, white, FixCross'); Screen('Flip', win);
WaitSecs(length);

%Practice trial - White noise
Screen('FillRect', win, black, FixCross'); Screen('Flip', win);
[bufferdata, freq] = audioread('Stimuli/Static.wav');
bufferdata=bufferdata';
PsychPortAudio('FillBuffer', songhandle, bufferdata);

[~] = PsychPortAudio('Start', songhandle, 1, 0, 1);
status=PsychPortAudio('GetStatus', songhandle);
while status.Active ==1; % wait until stim is finished playing
    status=PsychPortAudio('GetStatus', songhandle);
    WaitSecs(0.5);
end

DrawFormattedText(win, text{11}, 'center', 'center', white); Screen('Flip', win);
KbWait([], 2);

%% Block 1 Stimulus Presentation loop
% open port for Strim Tracker
fopen(sport);
%screen messages
DrawFormattedText(win, text{3}, 'center', 'center', white); Screen('Flip', win);
WaitSecs(2);
DrawFormattedText(win, text{4}, 'center', 'center', white); Screen('Flip', win);
WaitSecs(1);
DrawFormattedText(win, text{5}, 'center', 'center', white); Screen('Flip', win);
WaitSecs(1);
DrawFormattedText(win, text{6}, 'center', 'center', white); Screen('Flip', win);
WaitSecs(1);

for r=1:n; 
    rng(sum(100*clock)); %reset value so randperm is different for each participant.
    FileOrder=randperm(max(size(Data.item))); %determine random order of stimuli 
    EEG_data(end+1)=struct('type','FileOrder','timestamp',{FileOrder}); %save fileorder for this loop and time that block starts
    for i = 1:max(size(FileOrder));
        k=FileOrder(i);
        %get name of song
        song=Data.song{k};
        %create instructions
        if k>0 && k<=4
            text{17} = ['Please listen to \n\n'...
            ' ' song ' with lyrics \n\n'];
            text{18} = ['Please imagine \n\n'...
            ' ' song ' with lyrics \n\n' ...
            'following the cue'];
            text{19} = ['Please imagine \n\n'...
            ' ' song ' with lyrics \n\n' ...
            'when the fixation cross appears'];
            songInfo=[' ' song ' with lyrics'];
        elseif k>4 && k<=8
            text{17} = ['Please listen to \n\n'...
            ' ' song ' without lyrics \n\n'];
            text{18} = ['Please imagine \n\n'...
            ' ' song ' without lyrics \n\n' ...
            'following the cue'];
            text{19} = ['Please imagine \n\n'...
            ' ' song ' without lyrics \n\n' ...
            'when the fixation cross appears'];
            songInfo=[' ' song ' without lyrics'];
        else  
            text{17} = ['Please listen to \n\n'...
            ' ' song ' \n\n'];
            text{18} = ['Please imagine \n\n'...
            ' ' song ' \n\n' ...
            'following the cue'];
            text{19} = ['Please imagine \n\n'...
            ' ' song ' \n\n' ...
            'when the fixation cross appears'];
            songInfo=song;
        end       
        %get wavs
        msong=Data.musicfile{k}; %music.wav
        cue=Data.cuefile{k}; %cue.wav
        %get song length
        length=Data.length(k);

        %%%%%Perception trial%%%%%
        %instructions
        DrawFormattedText(win, text{17}, 'center', 'center', white); Screen('Flip', win);
        WaitSecs(4);
        Screen('FillRect', win, white, FixCross'); Screen('Flip', win);
        WaitSecs(0.5);
        
        %play music
        [bufferdata, freq] = audioread(msong);
        bufferdata=bufferdata';
        PsychPortAudio('FillBuffer', songhandle, bufferdata);
        EEG_data(end+1)=struct('type',{songInfo},'timestamp',{datestr(now,'yyyymmddTHHMMSSFFF')}); %save name and time that song starts
        fwrite(sport,['mh',1,0]); %send trigger
        fwrite(sport,['mh',0,0]); %turn trigger off
        [~] = PsychPortAudio('Start', songhandle, 1, 0, 1);

        status=PsychPortAudio('GetStatus', songhandle);
        while status.Active ==1; % wait until stim is finished playing
            Screen('FillRect', win, black); % hold fixation cross while stim is playing
            Screen('FillRect', win, white, FixCross'); Screen('Flip', win);

            status=PsychPortAudio('GetStatus', songhandle); 
            WaitSecs(0.5);        
        end

        %%%%%Cued Imagery Trial%%%%%
        %instructions
        DrawFormattedText(win, text{18}, 'center', 'center', white); Screen('Flip', win);
        WaitSecs(4);
        Screen('FillRect', win, white, FixCross'); Screen('Flip', win);
        WaitSecs(0.5);

        %play cue
        [bufferdata, freq] = audioread(cue);
        bufferdata=bufferdata';
        PsychPortAudio('FillBuffer', cuehandle, bufferdata);
        EEG_data(end+1)=struct('type',{'cued imag'},'timestamp',{datestr(now,'yyyymmddTHHMMSSFFF')}); %save type and time that cue starts
        fwrite(sport,['mh',2,0]); %send trigger
        fwrite(sport,['mh',0,0]); %turn trigger off
        [~] = PsychPortAudio('Start', cuehandle, 1, 0, 1);
        
        status=PsychPortAudio('GetStatus', cuehandle);
        WaitSecs(length+2);

        %%%%%Uncued Imagery Trial%%%%%
        %instructions
        DrawFormattedText(win, text{19}, 'center', 'center', white); Screen('Flip', win);
        WaitSecs(4);
        Screen('FillRect', win, black, FixCross'); Screen('Flip', win); %black screen for 1 sec
        WaitSecs(0.5);
        EEG_data(end+1)=struct('type',{'imag fix cross'},'timestamp',{datestr(now,'yyyymmddTHHMMSSFFF')}); %save type and time that fixation cross appears
        fwrite(sport,['mh',3,0]); %send trigger
        fwrite(sport,['mh',0,0]); %turn trigger off
        Screen('FillRect', win, white, FixCross'); Screen('Flip', win);
        
        WaitSecs(length);

        %%%%White Noise%%%%%
        Screen('FillRect', win, black, FixCross'); Screen('Flip', win);
        [bufferdata, freq] = audioread('Stimuli/Static.wav');
        bufferdata=bufferdata';
        PsychPortAudio('FillBuffer', songhandle, bufferdata);
        EEG_data(end+1)=struct('type',{'noise'},'timestamp',{datestr(now,'yyyymmddTHHMMSSFFF')}); %save type and time that noise starts
        
        fwrite(sport,['mh',4,0]); %send trigger
        fwrite(sport,['mh',0,0]); %turn trigger off
        
        [~] = PsychPortAudio('Start', songhandle, 1, 0, 1);
        status=PsychPortAudio('GetStatus', songhandle);
        while status.Active ==1; % wait until stim is finished playing
            status=PsychPortAudio('GetStatus', songhandle);
            WaitSecs(0.5);        
        end
    end
    if r<n;
        display('This is a break!!')
        DrawFormattedText(win, text{9}, 'center', 'center', white); Screen('Flip', win);
        KbWait([], 2);
        DrawFormattedText(win, text{3}, 'center', 'center', white); Screen('Flip', win);
        WaitSecs(2);
        DrawFormattedText(win, text{4}, 'center', 'center', white); Screen('Flip', win);
        WaitSecs(1);
        DrawFormattedText(win, text{5}, 'center', 'center', white); Screen('Flip', win);
        WaitSecs(1);
        DrawFormattedText(win, text{6}, 'center', 'center', white); Screen('Flip', win);
        WaitSecs(1);
    else
        display('Block 1 is finished!')
        DrawFormattedText(win, text{7}, 'center', 'center', white); Screen('Flip', win);
        KbWait([], 2);
    end
end

%when done, don't forget to close the serial port
fclose(sport);
%% Block 2 Stimulus Presentation loop
if test == 1;
    [win, rect] = Screen('Openwindow', 0, black, [0,0,900,600]); % Open win in small box on primary screen.
else
    [win, rect] = Screen('Openwindow', 1, black); % Open win on secondary screen. [Primary screen is "0"]
end
Screen('TextSize', win, 18);  

[X,Y] = RectCenter(rect);
FixCross = [X-1,Y-20,X+1,Y+20;X-20,Y-1,X+20,Y+1];  

% open port
fopen(sport);
  
DrawFormattedText(win, text{13}, 'center', 'center', white); Screen('Flip', win);
KbWait([],2);
DrawFormattedText(win, text{14}, 'center', 'center', white); Screen('Flip', win);
KbWait([],2);
DrawFormattedText(win, text{3}, 'center', 'center', white); Screen('Flip', win);
WaitSecs(2);
DrawFormattedText(win, text{4}, 'center', 'center', white); Screen('Flip', win);
WaitSecs(1);
DrawFormattedText(win, text{5}, 'center', 'center', white); Screen('Flip', win);
WaitSecs(1);  
DrawFormattedText(win  , text{6}, 'center', 'center', white); Screen('Flip', win);
WaitSecs(1);

%Save start time of Block 2
EEG_data(end+1)=struct('type',{'Beginning of Block 2'},'timestamp',{datestr(now,'yyyymmddTHHMMSSFFF')});

for 1:m;
    rng(sum(100*clock));
    FileOrderandperm(max(size(Data.item))); %determine random order of stimuli
    EEG_data(end+1)=struct('type','FileOrder','timestamp',{FileOrder});
    for i = 1:max(size(FileOrder));
        k=FileOrder(i);
         %get name of song
        song=Data.song{k};
        %create instructions
        if k>0 && k<=4
            text{19} = ['Please imagine \n\n'...
            ' ' song ' with lyrics \n\n' ...
            'when the fixation cross appears'];
            songInfo=[' ' song ' with lyrics'];
        elseif k>4 && k<=8
            text{19} = ['Please imagine \n\n'...
            ' ' song ' without lyrics \n\n' ...
            'when the fixation cross appears'];
             songInfo=[' ' song ' without lyrics'];
        else  
            text{19} = ['Please imagine \n\n'...
            ' ' song ' \n\n' ...
              'when the fixation cross appears'];
          songInfo=song;
        end  
        %get song length
        length=Data.length(k);
        %get name of song  
        msong=Data.musicfile{k}; %music.wav
        
        %%%%%Uncued Imagery Trial%%%%%
        %instructions
        DrawFormattedText(win, text{19}, 'center', 'center', white); Screen('Flip', win);
        WaitSecs(4);
        Screen('FillRect', win, black, FixCross'); Screen('Flip', win); %black screen for 1 sec
        WaitSecs(0.5);
        EEG_data(end+1)=struct('type',{songInfo},'timestamp',{datestr(now,'yyyymmddTHHMMSSFFF')}); %save song name and time that fix cross appears
       
        fwrite(sport,['mh',3,0]); %send trigger
        fwrite(sport,['mh',0,0]); %turn trigger off
        Screen('FillRect', win, white, FixCross'); Screen('Flip', win);
        WaitSecs(length);
        Screen('FillRect', win, black, FixCross'); Screen('Flip', win);
        WaitSecs(0.5);  
 
        DrawFormattedText(win, text{15}, 'center', 'center', white); Screen('Flip', win);
        KbWait([],2);
        [keyIsDown, secs, keyCode, deltaSecs] = KbCheck([]);
        EEG_data(end+1)=struct('type',{'keystroke'},'timestamp',{KbName(keyCode)}); %save type and name of next keystroke
        
    end
end
%when done, don't forget to close the serial port
fclose(sport);

display('Block 2 is finished!')
%% Save all information
EEG_data(end+1)=struct('type',{'end time'},'timestamp',{datestr(now,'yyyymmddTHHMMSSFFF')}); %save end time of task

save([subID '_EEG_Data'], 'EEG_data');

%End of task/thank you text
DrawFormattedText(win, text{16}, 'center', 'center', white); Screen('Flip', win);
KbWait([], 2);

sca;