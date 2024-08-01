// redFrik's SuperCollider tweets on X/Twitter.


// Important keyboard shorcuts
// cmd-.              Stop playing audio.
// shift-return       Execute a single line of code after putting the cursor in the middle or selecting it.
// cmd-return         Execute a block of code inside parentheses.
// cmd-b              Start a server.


// Server ops
// "s" is a global var that by convention stores the local server
s.boot;         // boot the remote server, create new allocators.           https://doc.sccode.org/Classes/Server.html#-boot
s.reboot;       // quit and restart the server application                  https://doc.sccode.org/Classes/Server.html#-reboot
s.quit;         // quit the server application                              https://doc.sccode.org/Classes/Server.html#-quit
Server.killAll; // kill all the processes called "scsynth" and "supernova"  https://doc.sccode.org/Classes/Server.html#*killAll


// Start the server with more than the memory default of 8192
s.options.memSize = 65536;
s.boot;


// Do the following if you're using airpods. It fixes this error:
// ERROR: Input sample rate is #XXXXX but output is #YYYYY. Mismatched sample rates are not supported.

    // 1. Kill all the servers.
    Server.killAll;

    // 2. List out your available input devices.
    ServerOptions.inDevices;

    // 3. Pick a better input than the airpods mic from the list of input devices.
    Server.default.options.inDevice_("MacBook Pro Microphone");

    // 4. Open the macOS Audio MIDI Setup utility.
    //    Set your selected input device's sample rate the same as the airpod's sample rate.
    "open -a 'Audio MIDI Setup'".unixCmd;

    // 5. Boot the local server
    s.boot;


// Show input and output level meter
s.meter;



// Feb 28
// https://x.com/redFrik/status/1762790022623674534
// notes:
// audio rating:
// spectrograph rating:
play{ar(LocalOut,z=ar(a=SinOsc,midicps(Scale.yu(\mean5)[b=(0..4)]+(ar(a,1/5*l=ar(LocalIn,5),b/5*2pi).round*12+60)),ar(DelayN,l,1,1/5)*2pi)/5);Splay ar:ar(HPF,z,9)}// #SuperCollider


// Jan 15
// https://x.com/redFrik/status/1746982829144113215
// notes: 11/8-ish
// audio rating: ***
// spectrograph rating:
play{ar(LocalOut,ar(DelayN,sin(ar(Hilbert,ar(LPF,ar(HPF,z=ar(LocalIn,14,(0!14)[0]=1/4)@@(1..14),140),11400),1.4).flop@1),d=0.14*1.4,d/(1..4)));Splay ar:z/4}// #SuperCollider


// May 28, 2023
// https://x.com/redFrik/status/1662778795697348609
// notes: Throws:
//        ERROR: Primitive '_QImage_SetPixel' failed. Index out of range.
// audio rating: 0
// spectrograph rating:
play{kr(PeakFollower,ar(BPF,ar(SoundIn),midicps((..136)),e=0.01),1-e)};w=plot(o=Image(p=137),"",p*3@p,1>0,nil,1<0);fork({loop{o.fill(Color());s.getControlBusValues(0,p).do{|a,x|asInteger(p+a.ampdb).do{|y|o.setPixel(0-p+y<<8,x,p-1-y)}};w.refresh;e.wait}},AppClock)// #SuperCollider


// Mar 4, 2023
// https://x.com/redFrik/status/1631979082622566400
// notes: innocent and beautiful. so chill.
// audio rating: *****
// spectrograph rating:
fork{do(inf,{|i|f=midicps(i div:60%2* -2+Scale.yu(\mean5)[i-(i div:11)]+70-(i div:12+1%2*12))+[0,2/3];play{ar(a=SinOsc,f+ar(a,f,0,f*1.5**ar(a,i%2*i div:[3,4]%7%6/4*3/(1+d=i div:12%3>>1),[i,i*2])),0,kr(XLine,0.1,1e-4,4+d,kr(AmpComp,f),0,2))};wait(d+[1,1/30]@@i)})}// #SuperCollider


// Dec 2, 2022
// https://x.com/redFrik/status/1598714366483959809
// notes:
// audio rating:
// spectrograph rating:
play{l=ar(a=SinOsc,9**ar(a,1/99)/b=(1..9));t=1-ar(Amplitude,p=ar(LocalIn,9)).lag(1/99);o=ar(a,99+l,l-t**ar(a,t**9*999/b)*9,t);{|i|o=o+ar(CombC,p=p.rotate,0.9,ar(a,1/b/9).range(*b**i/[99+9,99]),i+1)}!3;ar(LocalOut,o=tanh(ar(HPF,o*l.max*v=0.9**9,9)));ar(Splay,o*v)}// #SuperCollider


// Nov 11, 2022
// https://x.com/redFrik/status/1591161283591782401
// notes:
// audio rating:
// spectrograph rating:
r{loop{x.release(24);play(x={ar(Splay,ar(a=AllpassC,ar(a,ar(RLPF,ar(VarSaw,midicps({[0,2,5,7,9].choose+[36,48].choose}!4+l=kr(c=LFTri,d=1/12,b=(1..8)/4)/8),0,l+0.4),8**kr(c,d*b)*999),1,ar(c,[6,4,6]/4,[0,1])+1/2),1,1/2,4,d))},s,0,9);wait(9.rand/8+33.rand+8)}}.play// #SuperCollider


// Nov 10, 2022
// https://x.com/redFrik/status/1590835403157688320
// notes:
// audio rating:
// spectrograph rating:
play{ar(Splay,7**ar(a=SinOsc,g=1/(b=(1..9))/99)/9*ar(a,999*b.scramble/ar(f=RLPF,ar(c=Latch,round(ar(d=WhiteNoise),0.5)+2,ar(e=BrownNoise)+1.4>ar(a,b/999)),9**ar(a,g*9)*999,ar(a,b/77)/2+0.6))*ar(f,ar(c,ar(d),ar(e)+1.3>ar(a,b/99)),9**ar(a,g)*999,ar(a,b/88)/2+0.6))}// #SuperCollider


// Apr 28, 2022
// https://twitter.com/redFrik/status/1519791409921941507
// notes: Plays like a song
// audio rating: *****
// spectrograph rating:
play{(c=(f=ar(a=SinOsc,_,[0,5])).(25+f.(50.01)*ar(BLowPass,f.(0.1)/8+0.5*f.(252)*g=f.(5),round(g/2+1)/9**round(f.(1)*f.(5e-3)+1.02)*30*(g*3+40),0.05)*50)*f.(50.5*f.(50)/5+0.5)*f.(0.505)/5)+ar(d=PitchShift,c,0.5,0.5,0,0.5)+ar(d,c,0.5,round(5**f.(5e-3)),0.05,0.05)}// #SuperCollider


// Apr 1, 2022
// https://twitter.com/redFrik/status/1509888510525857792
// notes:
// audio rating:
// spectrograph rating:
play{ar(a=LorenzL,ar(a,7,13,10,2.1,0.1)+3*(4**ar(a,1)+0.5)*d=[8000,8008])*ar(a,1)/5};defer({play{b=[4,2,1,8,6];ar(Splay,9/b*max(0.5-ar(a,b/3+1))/2*ar(a,d/4*b,2**ar(a,2**ar(a,1))/12+10,ar(a,b/3).round(0.5).lag2*12+35,ar(a,1/11).round(1/3).lag2/12+0.153,0.1))}},13)// #SuperCollider


// Jan 6, 2022
// https://twitter.com/redFrik/status/1479212835192332289
// notes:
// audio rating:
play{d=ar(a=QuadC,5);ar(a,500)*d/99+ar(Splay,ar(a,999*b=[5,2.5,6])*ar(a,b/15).max/999*ar(a,b))+ar(AllpassN,ar(a,[12,16]*99)*ar(a,0.1,xi:[-0.5,-1]).max*ar(a,15).max/15+ar(Pan2,ar(a,99*b,1,ar(a,1/b/[15,5])>0*0.375-1.25).tanh,0.5*c=ar(a,b/15)*d,c).mean,e=1/15,e,15)}// #SuperCollider


// Dec 5, 2021
// https://twitter.com/redFrik/status/1467507942664646661
// notes:
// audio rating:
play{ar(Splay,3**ar(a=FBSineC,1/b=(1..8).rotate(6))/5*ar(a,999*b,2**ar(a,b/9)*4-1,ar(a,b/8)/2+1+(99**ar(a,1/4)/99),d=ar(a,b/12)>0/80+1.051,ar(a,1/b)/40+0.1)+(ar(a,ar(a,27+b)>0+2+b*d*1400,2,c=ar(a,1/b)+1,c/2,2,2)/12)+ar(HPF,ar(a,32)<0,3,ar(a,b*70/d)*ar(a,1/2)))/2}// #SuperCollider


// Nov 27, 2021
// https://twitter.com/redFrik/status/1464534258173849611
// notes: very complex, evolving noise
// audio rating: *****
play{y={|...x|ar(BBandPass,*x)};ar(Splay,y.(n=ar(GrayNoise,ar(a=SinOsc,1/(b=(1..13).rotate(3))/99).max),f=62.5*b,ar(a,0.5)+ar(a,b/999)/99+0.1,ar(a,b/666)+2)+y.(n,c=f*[6,3,7,5,1,8,4,2],9**ar(a,b/333)/99,666/c)+y.(n,c/2,9**ar(a,b/222)/99,888/c)*ar(a,1e-3,b/9).max)}// #SuperCollider


// Nov 16, 2021
// https://twitter.com/redFrik/status/1460601494932279300
// notes: trouble getting this to work
// audio rating:
//Quarks.install("UGenPatterns");
Quarks.install("https://github.com/redFrik/UGenPatterns");
Pbind(\dur,1/8,\degree,Pindex((0..9),Pdefn(\,0)%9)).play
Pdefn(\,PLFSaw(16)*9)
Pdefn(\,PLFSaw(16)*1+1)
Pdefn(\,PLFSaw(16)*2+2)
Pdefn(\,PLFSaw(20)*2+2)
Pdefn(\,PLFSaw(3.3)*2+2)
Pdefn(\,PLFSaw(3.3)*4+2)
Pdefn(\,PSinOsc(0.302)*40)
//etc #SuperCollider


// Oct 29, 2021
// https://twitter.com/redFrik/status/1454150378241548296
// notes: discernible pulse. danceable even.
// audio rating: *****
play{a={|r,i,n,q,p=0|ar(RLPF,ar(Impulse,r,p),kr(Select,i%5,[0,3,5,7,10]+n).midicps,q)};o=ar(Splay,[a.(2,ar(l=LFSaw,x=1e-3)*88,51,x*9),a.(1,0,70,x*5,b=(1..8)/8),a.(ar(l,1/9)+1,5**ar(l,b/9),82,x*3,b*3)/8,a.(3,ar(l,x*2,0.5)*88,63,x*7)/4].sum);o+ar(GVerb,o.sum/9,50)}// #SuperCollider


// Oct 27, 2021
// https://twitter.com/redFrik/status/1453520892374441986
// notes: sounds like what goes on in your head during a bad acid trip when you're curled up fetal in the dark with horrible bubble guts.
// audio rating: ****
// spectrograph rating:
play{t=ar(a=SinOsc,10,pi*b=(1..3)/3);o=ar(Splay,ar(Blip,ar(l=Latch,ar(a,b)>0*ar(a,b*50)+1/2*(300**ar(a,1/32,c=2pi*b)+99)+(ar(a,1/256,c).round*50+99),t%ar(a,99**ar(a,1/64))),ar(l,ar(a,ar(a,1/16)*3+12)+1/2*ar(a,1/8,c,50,51),t*ar(a,1/4))))/3;o+ar(GVerb,o.mean/3,30)}// #SuperCollider


// Oct 26, 2021
// https://twitter.com/redFrik/status/1452954849885163525
// notes: weird
// audio rating: **
// spectrograph rating:
i=0;r{loop{play{i=i+1;ar(Pan2,ar(Blip,exprange(t=ar(a=SinOsc,2**(i%11)*150/x=ceil(kr(a,i%9.33)*5+5)),kr(l=Latch,kr(a,i%4.4).exprange(9,999),y=kr(Changed,x)),kr(l,kr(a,i%pi).exprange(99,9e3),y)),t+2,1-t),kr(a,0.1,i),kr(Line,1,0,9,1,0,2).min(0.6)**2)};5.wait}}.play// #SuperCollider


// Oct 25, 2021
// https://twitter.com/redFrik/status/1452599226882535431
// notes:
// audio rating: *****
// spectrograph rating:
play{e=kr(a=LFSaw,0.1);ar(HPF,ar(Splay,ar(Blip,ar(a,kr(a,1e-3,b=(1..4)/2).round(ar(a,0.071)>0/8)*5).exprange(kr(l=Latch,2**kr(a,0.041,f=[0,1])*120-59,e),kr(l,2**kr(a,0.051)*500,e)),d=ar(a,11,f).exprange(2**kr(a,0.061,f)*4-1,2**kr(a,0.031,f)*20-8),1/d.max(1))),9)}// #SuperCollider


// Oct 24, 2021
// https://twitter.com/redFrik/status/1452318302768963589
// notes: Uses stethoscope XY scope
// audio rating:
// spectrograph rating: *****
play{o=ar(HPF,ar(Splay,ar(Blip,ar(a=SinOsc,(b=2pi*[4,3,1,2,5]/5)/9,b)/3+c=round(m=2**ar(a,1/50,b)*99,50),ar(CombC,c/50,2,b/2pi+ar(a,b/50,ar(a,ar(a,1/99,pi).max)**2pi).max,5),50/m*ar(a,b/50).max+0.5))*1.5,15).tanh;o+ar(GVerb,o.mean*kr(Line),50)/5};scope(s).style=2// #SuperCollider


// Sep 1, 2021
// https://twitter.com/redFrik/status/1433130309848027136
// notes: Conway's Game of Life
// audio rating:
// spectrograph rating:
w=plot(o=Image(c=99),"Life",c*5,1>0);AppClock.sched(0,{do(p=o.pixels,{|q,i|m=i%c@i.div(c);n=[a= -1,0@a,1@a,a@0,1@0,a@1,0@1,1].count{|e|p[(h=m+e%c).y*c+h.x]>d=a<<24};o.setPixel(if(case{q==d}{n==3}{q==a}{n>1&&(n<4)}{0.1.coin},a,d),m.x,m.y)});w.refresh;1/c})// #SuperCollider #Conway


// Aug 14, 2021
// https://twitter.com/redFrik/status/1426723573826265093
// notes:
// audio rating:
// spectrograph rating:
SynthDef(0,{|freq|ar(Out,0,ar(a=SinOsc,[f=kr(a,5)+freq]++({|i|i+2*f*1.gauss(d=1e-3)}!4),0,{|i|1-(i/8)**6}!5).mean*kr(XLine,d,1,0.08)+ar(PinkNoise,d*4)*EnvGate()!2)}).add;PmonoArtic(0,\note,(l=Pseq(_,inf)).(b=' #SuperCollider'.ascii+5%11)+6,\dur,l.(b+1/9),\legato,l.(b%3+1/3)).play

// Aug 6, 2021
// https://twitter.com/redFrik/status/1423569039016828934
// notes: FULLSCREEN Mandlebrot (move mouse to top of screen for menu)
// audio rating:
// spectrograph rating:
z=Image.color(w=720,h=540);do(w*h,{|i|b=(j=i div:w)/(h-1)*2-1;a=(i=i%w)/(w-1)*3.5-2.5;x=0;y=0;n=0;while({(e=x*x)+(f=y*y)<=4and:{n<999}},{y=2*x*y+b;x=e-f+a;n=n+1});if(n>2,{z.setColor(Color.hsv(v=n/999**0.5,1,1-v),i,j)})});z.plot("",nil,true).fullScreen// #SuperCollider #Mandelbrot

// Jul 23, 2021
// https://twitter.com/redFrik/status/1418556234949668867
// notes:
// audio rating:
// spectrograph rating:
play{z=ar(In,6,2);{|i|z=z+ar(AllpassN,ar(BPF,z,i+3*99,c=1/3,1.5),d=i+1/4,d)}!9;z.tanh};r{do(inf,{|i|y.release(30);y={ar(a=VarSaw,midicps(i%9+Scale.yu(\just).at(i)+42),0,ar(a,c/3)+2/4,lagud(ar(a,2.02,[0,0.5],ar(a,c/4)+1/4)>c,3e-4))/3}.play(s,6,i%6);25.wait})}.play// #SuperCollider

// Jul , 2021
// https://twitter.com/redFrik/status/1412538657735647234
// notes:
// audio rating:
// spectrograph rating:
n=play{|a|ar(Blip,[0,1]+e=255,a+3,a)};w=plot(o=Image(c=888,33),\,c);fork({do(inf,{|i|o.pixels=(z=o.pixels).overWrite(z,c).overWrite(z.class.with(*a=(b=div(e*f=sin(i/c),1))!c;{|j|a[c**sin(j/e+f)]=e-b}!e;set(n,\a,a@1/e);e<<8+a<<16));w.refresh;0.01.wait})},AppClock)// #SuperCollider

// Jul 6, 2021
// https://twitter.com/redFrik/status/1412423872280997901
// notes:
// audio rating:
// spectrograph rating:
play{ar(Saw,a=kr(In,0,e=32),a/d=255).sum.sin/4!2};w=plot(o=Image(e,d),\,12@6*99);r{do(inf,{|i|0.asBus.setn(l={|j|sin(i+j/d)+sin(i/e+j)*127%d}!e);o.pixels=(z=o.pixels).overWrite(z,e).overWrite(z.class.with(*d<<16+div(l,1)<<8));w.refresh;wait(4/d)})}.play(AppClock)// #SuperCollider

// Jul 6, 2021
// https://twitter.com/redFrik/status/1412395134965125120
// notes:
// audio rating:
// spectrograph rating:
play{kr(Out,0,l=ar(BPF,ar(SoundIn),1.1**(50..99),e=0.01));l.sum!2};w=plot(o=Image(50,150));r{do(inf,{o.pixels=(z=o.pixels).overWrite(z[..7450],50).overWrite(z.class.with(*asInteger(s.getControlBusValues(0,50).abs*1e6)+(1<<31)));w.refresh;e.wait;})}.play(AppClock)// #SuperCollider

// Jun 20, 2021
// https://twitter.com/redFrik/status/1406689360049754114
// notes:
// audio rating:
// spectrograph rating:
n=play{|z|ar(SinOsc,[3,2],z)/6};w=plot(o=Image(384,256),\,12@8*99);r{do(inf,{|i|o.pixels=Int32Array.fill(1e5,{|j|c=asInteger(sin(j*sin(i/1e4)*sin(i/4e3)+(x=j%385/50))/cos(i/(x+0.1))%256);248<<24+(c<<16)+(c<<8)+c});w.refresh;0.05.wait;set(n,\z,c)})}.play(AppClock)// #SuperCollider

// May 21, 2021
// https://twitter.com/redFrik/status/1395878538297892865
// notes:
// audio rating: *****
// spectrograph rating:
play{tanh(ar(f=CombN,c=ar(RLPF,ar(a=SinOscFB,ar(Demand,t=Impulse ar:5,0,Dseq(midicps(flat([24,0,3,5,7,10,36]+.t[36,48,36,33,60,72])),inf)/g=[3,2]),a ar:0.02,e=t.lagud(1e-3,ar(a,g/99)+1.08)),3**ar(a,0.04)+e*2e3,3**ar(a,g/9)/3,4).tanh,1,1/2,4)+ar(f,c,1,1/3,5)/8+c)}// #SuperCollider

// May 20, 2021
// https://twitter.com/redFrik/status/1395519538008141835
// notes:
// audio rating:
// spectrograph rating:
play{ar(LPF,tanh(sin(d=ar(HPF,ar(MantissaMask,c=ar(b=Duty,4e-3,0,Dseries(1,[1,2],i=inf)%ar(b,8.192,0,Dseq((1..6)*75,i)))),5))+ar(a=SinOscFB,63,(f=ar(a,_).max).(0.8),d)/9+ar(a,[250,200]*ar(b,4.096,0,Dseq([4,6,5,5,5,5,3]/4,i)).lag,f.(0.08),f.(1/[99,60])/3))/2,1e4)}// #SuperCollider

// May 19, 2021
// https://twitter.com/redFrik/status/1395040511795372038
// notes:
// audio rating:
// spectrograph rating:
play{clump(ar(HPF,ar(AllpassN,ar(a=SinOscFB,ar(Duty,b=[2,6,3,1],ar(a,b/9),Dseq((ar(a,b/24).round+(0..9)*7+29.17).midicps,inf)),ar(a,b/13).max/3*2)/8,1,0.51,8)+ar(GVerb,ar(BPF,ar(Hasher,ar(a,b/12).max,ar(a,b/c=500).max/c),2**ar(a,b/c*2)*1e4,1/99),99,9,0.2),50),2)}// #SuperCollider

// Apr 20, 2021
// https://twitter.com/redFrik/status/1384637855914418178
// notes:
// audio rating:
// spectrograph rating:
play{ar(LPF,Mix(Mix({|i|kr(Line,0,1,i*24)*ar(a=VarSaw,f=[kr(Demand,kr(a,(b=[1,2]+i/7)/64,i*b/40),0,Dseq(Scale.yu(\mean5).at((0..9).permute(i=i+1)),inf))+42,[30,33.084]].midicps.lag3.rotate(i)*i,0,ar(a,b/4*i/22,b)/6+0.2,kr(a,b/64/i,1/4)*kr(AmpComp,f))}!3))/9,1e4)}// #SuperCollider

// Apr 16, 2021
// https://twitter.com/redFrik/status/1383178379902525441
// notes:
// audio rating:
// spectrograph rating:
play{ar(f=LFCub,ar(x=Demand,t=ar(TDuty,(r={|q|Dseq(q.ascii,inf)}).("22221252222125222122121221212214")-48/12),0,r.("FDFA=A:FDFA=A:FHIHIIFHFHHDFDFFBF")+c=ar(PulseCount,t) div:32).midicps)*lagud(t,0)+ar(f,ar(x,y=ar(f,3),0,r.(":::::::::::8866:")+c).midicps,0,y<0)!2}// #SuperCollider


// Apr 15, 2021
// https://twitter.com/redFrik/status/1382854096621858816
// notes:
// audio rating:
// spectrograph rating:
play{ar(Splay,(b=ar(a=SinOscFB,1/64))*d=ar(a,[199,ar(a,1/24)<0*99+49,ar(a,1/128)>0*249+49,99]-(f=b<0*2)*c=ar(a,1/32)<0+1.05**ar(e=Blip,2,b+4).max,ar(a,1/[88,55,66,44]).abs);d+ar(PitchShift,d,1,2)/2+ar(e,249-f,c+1,ar(BPF,ar(CombN,d,1,3/[4,3,6,8]),999,0.45))).tanh}// #SuperCollider


// Mar 22, 2021
// https://twitter.com/redFrik/status/1374139774269857798
// notes:
// audio rating: *****
// spectrograph rating:
play{tanh(ar(a=SinOscFB,ar(a,1/64)<0*9+50,ar(a,1/8)+1/2,ar(HPF,c=ar(a,3)>0,4,5))!2+ar(Splay,ar(a,ar(Demand,ar(a,1/12),0,Dseq([1,1,2,3,4,1]*(ar(a,1/96)<0.5*19+99),inf)*b=[1,0.5,1.25]).lag3ud(1,3),ar(a,b/16)+1/3))+(ar(HPF,c>0.1,9**ar(a,1/19)+3)*ar(a,[12,9]*99)/6))}// #SuperCollider


// Mar 05, 2021
// https://twitter.com/redFrik/status/1367808902457397250
// notes: birds, birbs, sampler, glitch
// audio rating: *****
// spectrograph rating:
play{ar(Splay,{|i|ar(CombC,ar(a=SinOsc,Scale.yu.degreeToFreq(\fredaglunch.ascii%12@i,ar(a,1/16)>0*2+6-(ar(a,ar(a,1/32,i))/20),5))/9,0.5,i+floor(ar(a,1/64)*6+6).varlag(0.1)%11/33+0.1+varlag(ar(a,ar(a,1/4,i/11*pi)<0*2)*0.1,0.01,ar(a,0.01,i)),ar(a,1/9)+1)}!11).tanh}// #SuperCollider


// Mar 05, 2021
// https://twitter.com/redFrik/status/1367656279926247427
// notes:
// audio rating:
// spectrograph rating:
play{f={|x,y|ar(a,x,y?b).round};ar(Splay,c=ar(GrainSin,1,ar(a=SinOsc,f.(0.01,0)+10,b='TORSDAGKVÄLL'.ascii-64),0.85,f.(0.4)+f.(0.1)+2**f.(1/b)+1*99)/5;ar(HPF,ar(a,2,c*pi)+ar(PitchShift,c,0.5,f.(1)*f.(0.1)+2,0.05,1,0.15),5)+ar(a,50,0,ar(HPF,f.(1,[0,1]),1)/2)).tanh}// #SuperCollider


// Jan 30, 2021
// https://twitter.com/redFrik/status/1355524280356892677
// notes:
// audio rating:
// spectrograph rating:
//play: left&right arrow keys
fork{p=19;x=0;do(inf,{|i|if(i%99==0,{postln('score: '++div(i,99))});t=cos(i/5)/5+cos(i/29)*9+3;p=p+x;b=join($ !t)+$|+join($ !9)+$|;if(p<t,{0/$0});postln(b[p]=$.);x=0;0.1.wait;})};Document.current.keyDownAction_{|...k|x=k[5]-16777235}// #SuperCollider


// Jan 15, 2021
// https://twitter.com/redFrik/status/1350228172047003651
// notes:
// audio rating:
// spectrograph rating: ****
Pdef(\b,{|dur,note|Pbind(\instrument,SynthDef(\,{ar(Out,0,ar(SinOscFB,kr(\freq)*[1,2],kr(MouseY),EnvGate())/3)}).add,\dur,dur/3,\note,note+Pseq([-7,2,5]))});Pbind(\type,\phrase,\dur,Pseq((9..1),inf),\note,0-Pseq((12..8),inf),\instrument,\b,\recursionLevel,3).play// #SuperCollider


// Dec 27, 2020
// https://twitter.com/redFrik/status/1343283697840226307
// notes:
// audio rating:
// spectrograph rating:
scope{ar(Splay,ar(HPF,ar(Pluck,ar(WhiteNoise,ar(a=LFTri,b=(2..12)/12)+1/2)+ar(BrownNoise),ar(a,121**ar(a,2/121*b)),2/121,lag2(1/212>ar(a,1/212.1),2/b)/12*1.2+1.2/((Scale.yu(Tuning.just).degreeToFreq(_,121.21,2/12))!b.size),1/2*12/1.2,ar(a,b/12)+1/2),12,1/2.1/2))}// #SuperCollider


// Dec 26, 2020
// https://twitter.com/redFrik/status/1342895521309077504
// notes:
// audio rating:
// spectrograph rating:
play{ar(Splay,ar(Pluck,ar(a=SinOscFB,ar(a,b=(15..1)/5)*151.5*ar(a,b).round,ar(a,b/15).max,ar(a,b)+1/5),ar(a,1.51**5),c=1.51/515,d=ar(a,b/15).round.lag.range(c/1.515,c),1.5**ar(a,b,1)*5,1.51**ar(a,b)/5)+(ar(a,ar(a,b/15.1).round/5*1.5/d,e=ar(a,b/15).max,e/1.5)))/5}// #SuperCollider


// Dec 15, 2020
// https://twitter.com/redFrik/status/1338987643057688579
// notes:
// audio rating:
// spectrograph rating:
play{ar(HPF,ar(Splay,ar(Pluck,ar(a=VarSaw,[18.1,81.8,1.81]+b=(8..18),1,ar(a,b/81)),ar(a,8/1.818,[1,8/18]),1.8/181.8,ar(a,b/181.8).exprange(1.81/818,1.8/181.8).round(1.81/818),ar(a,1/8,1/b)+8.18*1.8,ar(a,1/81.8).range(1.8** -1,8.1/8.18),ar(a,1.8/b))/1.8),18/1.81)}// #SuperCollider


// Nov 02, 2020
// https://twitter.com/redFrik/status/1323409057777176576
// notes:
// audio rating:
// spectrograph rating:
fork{do(inf,{|j|a=play{ar(Splay,{|i|ar(Blip,2+ar(b=LFTri,4,i/6,1e-3)**i+1*[1,1,9/8,2/3,0.5,2,3/4]@@(j/2),2**ar(b,i+1/99,i/6)*4,ar(Decay,ar(Impulse,[1,4,6,2,3]@@(j-i),[0,0,i/1.5,i/2]@@(j+i),ar(Sweep,0,0.5)),ar(b,0.01,i/6)+2/4))}!12).tanh/3};4.wait;a.release(14)})}// #SuperCollider


// Oct 30, 2020
// https://twitter.com/redFrik/status/1322231843740143616
// notes:
// audio rating:
// spectrograph rating:
fork{do(inf,{|j|a=play{z=mean({|i|ar(Pan2,ar(o=SinOscFB,kr(o,i+6,1,6-1)+midicps(66-1+Scale.yu.tuning_(Tuning.mean6)[j+i]),kr(o,1+i/6/6).max),kr(o,i+1))}!d=j%6+1);ar(PitchShift,z,1,[1.66+1,1.66],t=1/66,t)/6+z+ar(o,66-1,1,ar(o,6,1).max)/6};wait(d+6);a.release(6)})}// #SuperCollider


// Oct 24, 2020
// https://twitter.com/redFrik/status/1319946903711338496
// notes:
// audio rating:
// spectrograph rating:
fork{https://t.co/neHahxw7Ub{a={|i|c=Scale.minor.tuning_(Tuning.mean5);z=sum({ar(Pan2,ar(SinOscFB,kr(o=LFTri,1/99)*9+midicps(12*(3..6).choose+c[c.degrees.choose]),kr(o,1+i/50)+1/2),kr(o,i/70))/2}!d=9.rand);ar(CombN,z).tanh}.play(s,0,9);wait(d*9+3);a.release(12)}}// #SuperCollider


// Apr 26, 2020
// https://twitter.com/redFrik/status/1254441448327479299
// notes:
// audio rating: *****
// spectrograph rating:
play{ar(FreeVerb,ar(Splay,ar(SinOscFB,ar(DegreeToKey,as(b=[1,3,5,8,10],LocalBuf),ar(Duty,(e=[3,2/3,4,3/2,2])/(12**ar(a=LFTri,b*c=0.021)),0,ar(a,b*c)*7+20+Dseq(b%(ar(a,b*c)*5+6),inf))).midicps,ar(a,c/b)+1/3,ar(Decay2,ar(Impulse,e@@b),c,d=ar(a,b/999)%1)*d)),0.1,1)}// #SuperCollider


// Apr 13, 2020
// https://twitter.com/redFrik/status/1249684060101902338
// notes:
// audio rating:
// spectrograph rating:
"VdaUhdv'(-lhmRhyd^'555(-eqnms-tqk<!`qbghud-nqf.cnvmkn`c.$.$-lo3!-enql`s')&Qhbj^@rskdx^Mdudq^Fnmm`^Fhud^Xnt^To& 1(".collect{|x|asAscii(x.ascii+1)}.interpret// #SuperCollider


// Apr 04, 2020
// https://twitter.com/redFrik/status/1246461901669838848
// notes:
// audio rating: *****
// spectrograph rating: *****
play{d=ar(a=SinOscFB,kr(Pitch,ar(b=LFPulse,ar(b,1/[8,9]+ar(b,0.1)).lag(ar(a,1/11)/2+1/9)*4/3+1**ar(b,1/[9,8])*ar(b,1/11,0,1/4,99,99)).lag(ar(a,1/[5,4]).max/9).sum)[0],ar(b,1/[ar(b,1/9)+2,3]).lag/4+0.3);ar(HPF,d+ar(PitchShift,d/2,2,[3,2]-ar(b,1/[18,17]).lag),9)/2}// #SuperCollider


// Mar 04, 2020
// https://twitter.com/redFrik/status/1235224072579100675
// notes:
// audio rating:
// spectrograph rating:
play{ar(Splay,o=ar(BPF,ar(Normalizer,ar(v=SinOsc,(b=(tanh(pi)..f=tab(Char).ascii)*pi*pi)*f,c=b.reciprocal,ar(v,c).max)+ar(AllpassC,ar(LocalIn,f),e=floor(f%pi),ar(v,c/f)/f+e/e,e,e),e/e,c),ar(v,c).exprange(f,e**f*f));ar(LocalOut,o.rotate);o).sin};s.scope(e).style=e// #SuperCollider


// Dec 26, 2019
// https://twitter.com/redFrik/status/1210118661022867458
// notes:
// audio rating: ****
// spectrograph rating:
play{c=ar(e=SinOsc,0,pi**ar(SinOscFB,ar(Duty,b=("00".size.."0000000".size).reciprocal,0,Dseq("0 0 00 0 0 000  _0 0 0 00 00 00000+  !".ascii,inf)),ar(e,d=$0.ascii.reciprocal).max*0.cos.sin));ar(LeakDC,ar(Splay,c+ar(PitchShift,c,e=0.cos.cos,b.reciprocal,d,d,b)))*e}// #SuperCollider


// Dec 10, 2019
// https://twitter.com/redFrik/status/1204602890574352385
// notes:
// audio rating:
// spectrograph rating:
play{a=VarSaw;ar(LeakDC,ar(LPF,ar(Splay,ar(b=CombN,ar(b,cos(ar(a,[11-1,11<<1,11,11>>1,11+1]**ar(a,11.1,1,1/11,1,1.11111111))*ar(a,d=1/(1..11)/1,d,1/11,ar(a,1.11/d,1,1.1-d,11),1)),d,d+1/(111>>1),ar(a,d*11/111,1,1/(c=1+1),1,1.1/c,d).max,1/c),c,c/11/d)),11111)).sin}// #SuperCollider


// Nov 20, 2019
// https://twitter.com/redFrik/status/1197185125819277312
// notes:
// audio rating:
// spectrograph rating: *****
play{c=ar(RHPF,ar(CombN,ar(a=SinOsc,e=(f=[2,2.2])/22)/2*ar(LocalIn,2),2,2,g=2<<2),[22,2]*222,e*2);ar(LocalOut,d=ar(Splay,ar(RLPF,ar(a,2.2**ar(t=ToggleFF,ar(p=LFPulse,2,[2.2,2],e))*22*2.22,ar(t,c-e).lag*g)*ar(p,2,f),g**ar(a,e/2/2)*2222/2,ar(a,e)+2/2pi)+c).tanh);d}// #SuperCollider


// Aug 26, 2019
// https://twitter.com/redFrik/status/1166129504747773954
// notes: good noise tune
// audio rating:
// spectrograph rating: *****
play{r=ar(Splay,(ar(a=LFTri,{|i|i+3.33+ar(a,3/3333)}!3%3*33*(3/3pi+kr(c=LFPulse,3e-3*3)),3,_+3!3).reduce('*').tanh*[3,333*ar(a,3/3333),33])).sin+ar(a,3*3**[3.3,3]+(ar(a,[3,pi])),3,ar(c,pi)/3*ar(a,3e-3))/3;r+sum({|i|ar(b=PitchShift,r,3/33,3/3+i*3,3/33,3/33)}!3)/3}// #SuperCollider


// Jun 24, 2019
// https://twitter.com/redFrik/status/1143262368392200192
// notes: spectrograph looks like iron fence
// audio rating:
// spectrograph rating: *****
play{ar(Splay,ar(RLPF,ar(a=VarSaw,ar(a,(c=4/4/4)/4,c,c).max*4+44,4,ar(a,[4,4/44,c*4]).abs),44*44,c)*ar(Line,dur:4)+ar(PitchShift,ar(CombC,b=ar(a,f=ar(a,d=c*4/44.4,c,-4.sin,4).max.ceil*44+44,4,ar(a,[44-4,4,44+4]/4.44))/4,c,c*4/f+d),4-c,[4+4+4,4*4,4+4],c,c,c+c))/4}// #SuperCollider


// Jun 11, 2019
// https://twitter.com/redFrik/status/1138498427241861122
// notes:
// audio rating:
// spectrograph rating:
play{b=[f=9.sqrt,9.999];c=ar(e=PitchShift,ar(a=SinOscFB,lag(9.9*b*if(ar(a,ar(a,9/999))>ar(a,9/99),f,9/b)*if(ar(a,9/99)<ar(a,99/9999),b/9,f)),d=ar(a,b/99).max,ar(a,b/9)*d),9/b,9/b.sqrt,b/999,b/99);ar(HPF,ar(Splay,ar(GVerb,c*d*d*d,99,9,9/999)/9+ar(e,c,f/9,f/9)),9)}// #SuperCollider


// Jun 07, 2019
// https://twitter.com/redFrik/status/1136928201886904320
// notes: spectrograph looks like crystal towers
// audio rating: *****
// spectrograph rating: *****
do([LFTri,LFSaw,LFPar],{|a,i|play{c=round(ar(a,1/b=[4,2,1,3,5])*b,ar(a,b/9)>0);Splay ar:(x=ar(AllpassC,ar(SinOscFB,c**2*(ar(a,0.02,i)>0+1*50),ar(a,c/9)%1,max(ar(a,1/b*ar(a,b/99,i)))*ar(a,0.01,i)),1,c.wrap(0.5,1),2);x+ar(BPF,x,i*99+400,1e-3,ar(a,0.04,i)+1*9))/3}})// #SuperCollider


// May 07, 2019
// https://twitter.com/redFrik/status/1125557217086857216
// notes: chill oxygene
// audio rating: ****
// spectrograph rating: ****
play{ar(Splay,ar(AllpassN,ar(RLPF,ar(VarSaw,f=kr(DegreeToKey,LocalBuf.newFrom(Scale.yu(Tuning.pythagorean).semitones),kr(a=LFTri,b=(-7..6)+0.7*2/666,b,kr(a,b))*9+9%32,12,1,24).midicps,0,kr(a,b)+1/2,kr(AmpComp,f)*kr(a,b,b)*b*9),f.lag2(1/b%1)*3),0.3,0.2-b,3)).tanh}// #SuperCollider


// Apr 09, 2019
// https://twitter.com/redFrik/status/1115745664523218944
// notes: Radiohead, but painfully loud
// audio rating:
// spectrograph rating:
play{a=SinOsc;ar(HPF,ar(Splay,ar(CombC,ar(a,ar(Duty,c=2**ar(a,b=[1,2,6,3]+(ar(a,0.0345)<0)),0,Dseq(99*ar(a,1/b,0,b/3,b*(ar(a,0.0234)<0+1)).round,inf)),b,ar(a,1.5/c).max(ar(a,0.0123,0,0.5,-0.5))),1,7-b/12*(ar(a,c<0.6)%1+0.1),2**ar(a,ar(a,0.1,0,0.1),b,9))),9).tanh}// #SuperCollider


// Mar 12, 2019
// https://twitter.com/redFrik/status/1105496695637454848
// notes: Radiohead
// audio rating:
// spectrograph rating: ****
play{a=VarSaw;Splay ar:ar(BLowPass,ar(a,kr(a,b=(1..15)/151,b,1/5.15,1,1.5).ceil*kr(Select,kr(a,1/15,1/5,b,5).ceil+5/5,[51*1.5,51,151]).lag(b)+kr(a,5+b)*kr(a,b,b,b,b/5,[1.5,5,1]),b,kr(a,b)+5/15,kr(a,5-b,b,b,5,5)>1.515),1515**(kr(a,1-b/5)/15+1+b),1.5**kr(a,b)/5)/5}// #SuperCollider


// Mar 04, 2019
// https://twitter.com/redFrik/status/1102801295273017344
// notes:
// audio rating:
// spectrograph rating: ****
play{a=LFSaw;ar(Splay,c=ar(VarSaw,round(1+ar(a,1/b=(1..9))/19+1.9**b+91*if(ar(a,1/19)+1>1,1,1.9).lag,91+ar(a,b/9+1)).lag,b/9,1/19);c+ar(CombN,ar(RHPF,c*ar(a,1/91,b/9).lag,91*1.9*b,9/19),1,b/9,9)+ar(RLPF,(f=ar(a,9.1))+1<ar(a,91)+c*f,19*19,ar(a,f)+1.9/9)/1.9).tanh}// #SuperCollider


// Jan 30, 2019
// https://twitter.com/redFrik/status/1090772694038126592
// notes: cool lick, repetitive 5,3 thing
// audio rating: ****
// spectrograph rating: *****
a=play{|n=48|x=perform(LFTri,\kr,_);perform(BLowPass,\ar,perform(Pulse,\ar,perform(Duty,\kr,1/8,0,Dseq([1,8,13,1,13,1,11,6,1,8,1,13,1,11,1,13]+n,inf).midicps)+[0,0.4],x.(1/9)/6+0.2),2**x.(0.1)*400,x.(1/7)/7+0.3).tanh};MIDIIn.connectAll.noteOn={|i,c,n|a.set(\n,n)}// #SuperCollider


// Jan 13, 2019
// https://twitter.com/redFrik/status/1084601286488674304
// notes: plucky
// audio rating: ****
// spectrograph rating: ****
play{LocalOut ar:d=MoogFF.perform(\ar,PitchShift.perform(\ar,LocalIn ar:2,1.5,0.5)+Splay.perform(\ar,VarSaw.perform(\ar,(a=LFSaw.perform(\ar,_)).(1/b=[2,5,1,6,3])>0/4+1.25**b*99,0,a.(b/9)%1)*HPF.perform(\ar,a.(a.(1/b).round+1/2)>0,a.(b/33)*4+8)),a.(1/9)+2*4e3);d}// #SuperCollider


// Dec 19, 2018
// https://twitter.com/redFrik/status/1075520529040334858
// notes: FULLSCREEN (move mouse to top of screen for menu)
// audio rating:
// spectrograph rating:
ScopeView().fullScreen(1>0).server_(s).bufnum_(b=Buffer.alloc(s,256)).style_(2).start;play{d=VarSaw;f=d.perform(\ar,_);https://t.co/wn9JJcFDtJ(a=CombC.perform(\ar,d.perform(\ar,f.(c=[2,3])>0+c*66,0,f.(c/666)+1/2),1,f.(c/9).round+1/3+(9**f.(6e-3)/9),7-c).sin,b);a}// #SuperCollider


// Dec 13, 2018
// https://twitter.com/redFrik/status/1073301641032540162
// notes: FULLSCREEN (move mouse to top of screen for menu)
// audio rating:
// spectrograph rating:
UserView(x,1200@900).front.drawFunc_{{|j|Pen.fillColor_(Color.white).fillRect(r=Rect((i=i?0+1)%(1199-j),i/99%(999-j),i%12,j%16)).strokeRect(r)}!99}.clearOnRefresh_(1<0).frameRate_(999).animate_(1>0)// #SuperCollider port of one of my old #processing tweets https://t.co/HMAM7u225C https://t.co/rT9Y8aerR2


// Dec 13, 2018
// https://twitter.com/redFrik/status/1073227217424007168
// notes:
// audio rating:
// spectrograph rating:
UserView(x,800@800).fullScreen(1>0).drawFunc_{i=i?0+1;Pen.translate(400,400);{|j|Pen.width_(i/(j+1)%50).color_(Color.hsv(sin(i*j/47)+1/8,1,sin(i+j/46)+1/2,0.05)).strokeOval(Rect(sin(i/63)*300,sin(i/48)*250,r=sin(i/64)*99,r))}!5}.clearOnRefresh_(1<0).animate_(1>0)// #SuperCollider


// Nov 24, 2018
// https://twitter.com/redFrik/status/1066351458646409216
// notes: frame drums
// audio rating:
// spectrograph rating:
play{f={|...a|LFTri.perform(\ar,*a)};g=DelayN.perform(\ar,_);c=Splay ar:GVerb.perform(\ar,Splay ar:HPF.perform(\ar,f.(2/b=8.fib.mirror)>f.(1/b),f.(1/b/2)+1.03*3e3),b,5,*f.(1/6.fib/12)+1/2);c+f.(54,[0,1],RLPF.perform(\ar,d=g.(c),999))+RHPF.perform(\ar,g.(d),99)/8}// #SuperCollider


// Oct 05, 2018
// https://twitter.com/redFrik/status/1048295821136072705
// notes: 19/8 (4 4 4 4 3, or 3 3 3 3 3 4)
// audio rating:
// spectrograph rating:
play{x={|z...y|perform(z,*y)};Splay ar:({|i|(b=x.(a=SinOscFB,f=\ar,x.(e=Duty,f,i+1/9,0,Dseq(9.fib%8,inf))/c=1/x.(e,f,1+i/8,0,Dstutter(24,Dseq(99/(1..4),inf))).lag(4),x.(a,f,c)))*x.(CombN,f,b,1,i/99+0.1)/8+x.(Ringz,f,x.(Pulse,f,4/9,i/19.4,c),b+1*99,c).tanh/4}!20)}// #SuperCollider


// Sep 14, 2018
// https://twitter.com/redFrik/status/1040686477552873475
// notes: spectrograph looks like fabric
// audio rating:
// spectrograph rating: ****
play{a=SinOsc;c=VarSaw;Splay ar:perform(a,x=\ar,0,perform(BRF,x,perform(c,x,perform(c,x,perform(a,x,b=(6..1)*2.1)*b,0,7-b/9)>0+(perform(a,x,1/b)>perform(a,x,0.1/b)+1)*[99,198]*b/9,0,perform(c,x,b/48)+1/2),2**perform(c,x,b/24)*488,0.4)*perform(a,x,0.012,b,2pi))/2}// #SuperCollider


// Jun 29, 2018
// https://twitter.com/redFrik/status/1012743451019005952
// notes: Minecraft
// audio rating:
// spectrograph rating: ***
play{a=LFTri;c=perform(Splay,x=\ar,perform(Resonz,x,perform(VarSaw,x,5,0,d=perform(a,x,0.15,b=(1..5)),perform(EnvGen,x,Env.perc(f=15e-4,0.05,d,d*5),perform(a,x,b/1.5))),1.5**b*(50*perform(a,x,0.015,b/5).round+150),d+1.15*f,150));c+perform(PitchShift,x,c,1.5,0.5)}// #SuperCollider


// Jun 23, 2018
// https://twitter.com/redFrik/status/1010690836244377601
// notes: Whitney Music Box, Spectrograph is scenic
// audio rating:
// spectrograph rating: ****
play{a=VarSaw;b=(2..6)/4;c={|f,v|Splay ar:perform(BBandPass,\ar,perform(CombC,\ar,perform(a,\ar,f*b+perform(a,\ar,4,0,0.4,v/14),0.4,perform(a,\ar,b/40)+1/4),2,perform(a,\ar,perform(a,\ar,b/4e4)+1*b/4,b/400).lag+1,4)/v,4**b*44%1e4,9).tanh};c.(140,14)+c.(1400,144)}// #SuperCollider


// Apr 19, 2018
// https://twitter.com/redFrik/status/986945296054841344
// notes: minimalistic pad
// audio rating: *****
// spectrograph rating:
play{a=SinOsc;f={|...x|1.5**perform(a,\ar,*x)};Splay ar:({|i|l=perform(a,\ar,f.(i+5/150)<1).abs.round(0.5);y=perform(VarSaw,\ar,1.5**l*(f.(l/155,0,5).ceil*50.05),0,f.(l*f.(l/50))-0.55,max(f.(i+1/500.05)-1,0));y+perform(PitchShift,\ar,y*f.(0.1),0.5,5,0.05,1)}!15)}// #SuperCollider


// Apr 01, 2018
// https://twitter.com/redFrik/status/980549809122750471
// notes: cool rhytms
// audio rating: ****
// spectrograph rating:
play{q=SinOsc;a={|x...y|perform(x,\ar,*y)};Splay ar:a.(CombN,c=a.(q,0,a.(Blip,1/f=(1..8),888/a.(q,1/88,0,2,3).ceil*a.(Duty,a.(q,1/8)>0+2*1/8,0,Dseq([8,88,888],inf)))*188),1,8-f/8,8)/8+a.(CombN,a.(GVerb,a.(BPF,8*e=c.mean,88,1/8),88),1,1)+a.(q,88,0,a.(q,0,e)<0/88)}// #SuperCollider


// Jan 08, 2018
// https://twitter.com/redFrik/status/950423158011695104
// notes:  cool, subtle tones buried in the clicks and noise. forever descending,  Spectrograph has descending lines
// audio rating: ****
// spectrograph rating: *****
play{Klang.ar(`[(_.linexp(0,2e4,99,1e4))!2e4,1e-3]).tanh!2}// #SuperCollider 20000 sines, 59 characters, ~69% cpu, macbook pro mid 2015, sc3.9


// Nov 19, 2017
// https://twitter.com/redFrik/status/932266285773312001
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;e=EnvGen.ar(Env.perc(5e-3,0.2),t=a.ar([7.992,8]));f={|i|Demand.ar(t[i],0,Dseq([Dseq('@BGIJB@IGBJI'.ascii,240),Dseq('@LEGJLEG'.ascii,120),Dseq('EGJL'.ascii,60)])).midicps}!2;x=a.ar(f,a.ar(1/[12,9])/4+1*a.ar(f,e*pi))*e/2;FreeVerb2.ar(x@0,x@1,0.1,1,0)}// #SuperCollider


// Oct 26, 2017
// https://twitter.com/redFrik/status/923641653101056001
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;Splay ar:Pulse.ar(wrap((1..4)/(a.ar(2/3)<0+3)**a.ar(b=a.ar(1/[4,3])).ceil.lag*99*[2,3,4,8,1],20,1e3),2-b/3)%1}// #SuperCollider


// Oct 26, 2017
// https://twitter.com/redFrik/status/923640190266114054
// notes:
// audio rating:
// spectrograph rating: *****
play{a=LFTri;Splay ar:Pulse.ar(fold((2..5)/(a.ar(0.1)>0+2)**a.ar(b=a.ar(2/(9..7))).ceil.lag*99*[3,1,8,2,4],9,999),2-b/5)/2}// #SuperCollider


// Oct 22, 2017
// https://twitter.com/redFrik/status/922100382742011904
// notes: Spectrograph, cool curves in upper freqs
// audio rating:
// spectrograph rating: *****
play{a=VarSaw;HPF.ar(BLowPass4.ar(a.ar((a.ar([7,6])<0+b=a.ar(c=1/[31,23]))>1+1*99,0,1-b/2)%b,4**a.ar(c)*666,0.08).sin/2,9)}// #SuperCollider


// Oct 01, 2017
// https://twitter.com/redFrik/status/914470619529572352
// notes: Spectrograph has alien heads
// audio rating: *****
// spectrograph rating: *****
play{a=LFTri;Splay ar:BHiPass4.ar(BLowPass4.ar(a.ar(b=[4,16,3])*a.ar(b*b),8**a.ar(b/50).round*99),3**a.ar(1/b)*99,0.1).sin}// #SuperCollider


// Sep 04, 2017
// https://twitter.com/redFrik/status/904702313482391552
// notes:
// audio rating:
// spectrograph rating: ****
play{a=LFSaw;Splay.ar(MoogFF.ar(a.ar(a.ar(9,2/b=(1..9)))>0.05*GrayNoise.ar(999)*a.ar,2**a.ar(b/3.55).round*b*99,3.5)).tanh}// #SuperCollider


// Sep 02, 2017
// https://twitter.com/redFrik/status/904049975780413443
// notes:
// audio rating:
// spectrograph rating: *****
play{a=LFTri;c=Klank.ar(`[[12,4,3,9,10]*2*99],a.ar(5*b=[1,9/8]),b)*d=a.ar(b/8);a.ar(b*2).sum<0*SinOscFB.ar(b*99,d+1/2)+c/2}// #SuperCollider


// Aug 28, 2017
// https://twitter.com/redFrik/status/902146203877601280
// notes: minimalist phasing
// audio rating: *****
// spectrograph rating: *****
play{a=LFSaw;sum({|i|AllpassN.ar(RHPF.ar(Saw.ar(a.ar(1/[99,100]).round(1/8)**2*8),2**i*[99,50],0.01),1,i+1/9,9)/9}!8).tanh}// #SuperCollider


// Aug 25, 2017
// https://twitter.com/redFrik/status/901088699835928577
// notes: Heavy riff, good rhythm
// audio rating: *****
// spectrograph rating: *****
play{a=SinOsc;c=a.ar(999**(a.ar(3)*a.ar([3,1]/8)%1),a.ar(0.03,a.ar(98)*a.ar(0.02,[0,1],3),4));c+a.ar(99,c*a.ar(0.01)*12)/3}// #SuperCollider


// Aug 22, 2017
// https://twitter.com/redFrik/status/899979979668283392
// notes:
// audio rating:
// spectrograph rating: *****
play{LocalOut.ar(b=HPF.ar(Saw.ar([50,99],9e3**lag(Saw.ar([9,8])+LocalIn.ar(2),LFTri.ar(1/[19,18])/19+0.09)).cos,9));b.tanh}// #SuperCollider


// Aug 10, 2017
// https://twitter.com/redFrik/status/895757440817528832
// notes: clock chimes, whitney music box type phasing
// audio rating:
// spectrograph rating: *****
play{a=LFSaw;Splay ar:CombN.ar(GVerb.ar(a.ar(a.ar(b=(9..1)/99,b)+1*99,b,a.ar(a.ar(b)>b)>0.9),99,1,b*9,b)/19,1,b/9.9,9,0.9)}// #SuperCollider


// Aug 05, 2017
// https://twitter.com/redFrik/status/893964744390037506
// notes: rhythmic chirping
// audio rating:
// spectrograph rating: *****
play{a=SinOsc;b=Duty;c={Dseq([5,1,3,2],1/0)};a.ar(b.ar(e=1/[8,4],0,c.()*b.ar(e/4,0,c.()))*b.ar(1/e,0,c.()*28.8))*a.ar(e/9)}// #SuperCollider


// Aug 02, 2017
// https://twitter.com/redFrik/status/892874938838855680
// notes:
// audio rating:
// spectrograph rating: *****
play{a=VarSaw;Splay ar:AllpassC.ar(9**(c=a.ar(0.1/b=[9,4,3,6]/4)+1/9)*a.ar(round(a.ar(c/3)+b,b)*99,0,c),1,c+9/99,9).tanh/2}// #SuperCollider


// Jul 08, 2017
// https://twitter.com/redFrik/status/883698373030817792
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Splay.ar({|i|VarSaw.ar(round(a.ar(c=i/48)*a.ar(b=c/72)*8+9,i%9+1)*25+c,c,a.ar(3,i)+1/3,a.ar(b,i/pi)%1)/2}!30)}// #SuperCollider


// Jul 04, 2017
// https://twitter.com/redFrik/status/882213718242861056
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;c=a.ar(1-a.ar(1/[3,2]).round(0.5)+InFeedback.ar(0,2));a.ar(2**a.ar(1-c).round(1-c)*400,c.abs,c.lag*c).tanh}// #SuperCollider


// Jun 19, 2017
// https://twitter.com/redFrik/status/876713359072264192
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;Splay.ar({|i|a.ar(1+i).max(c=a.ar(8-i/8))*a.ar(a.ar(i-2.1)%a.ar(9,1)+(a.ar(1)>0/3+1.83)**i+99,c+1/4)}!8)/2}// #SuperCollider


// Jun 08, 2017
// https://twitter.com/redFrik/status/872862712501555201
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;a.ar(RLPF.ar(a.ar(9+c=1.1**a.ar([6,8]),a.ar(c/9)%a.ar(a.ar(c/14)*999))>0.99*999,c/4+1*99,a.ar(c/9)/19+0.06))}// #SuperCollider


// Jun 03, 2017
// https://twitter.com/redFrik/status/871135477369380866
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;Splay ar:a.ar(4**a.ar(b=0.01/(2..6))*99,c=a.ar(1-b*8,1/2)+1/2,Decay.ar(c>0.99512*a.ar(c+1/b),1/2)/22).tanh}// #SuperCollider


// May 29, 2017
// https://twitter.com/redFrik/status/869140771286523904
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Splay ar:SinOscFB.ar(round(2**a.ar(b=(1..8)/128)*256,64),c=a.ar(b)%1,RLPF.ar(a.ar(1/b/32),500,1.01-c)).clip/2}// #SuperCollider


// May 16, 2017
// https://twitter.com/redFrik/status/864503776983613440
// notes: dark basketball court on acid
// audio rating: *****
// spectrograph rating:
play{a=LFTri;e=a.ar(2**a.ar(1/5)).round(a.ar(1/8)/3);GVerb.ar(HPF.ar(SinOsc.ar(e**[99,150],BPF.ar(e%1,500))/6,9),99,5,0.1)}// #SuperCollider


// May 02, 2017
// https://twitter.com/redFrik/status/859365775521525760
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;AllpassN ar:a.ar(midicps(Duty.ar(c=a.ar(1/[12,8])+3/24,0,Dseq([0,8,5,1,5,4,5]*round(c*18),inf))+60),c*2)/2}// #SuperCollider


// Apr 14, 2017
// https://twitter.com/redFrik/status/852893898997469184
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Splay.ar(Formant.ar(*[2**round(a.ar(b=1/(1..12)),a.ar(8,b)<0/4+1),4**a.ar(b/12)+2,3**a.ar(b/4)*3]*99)/2).tanh}// #SuperCollider


// Apr 12, 2017
// https://twitter.com/redFrik/status/852077804112027649
// notes:
// audio rating:
// spectrograph rating:
play{a=Pulse;Splay.ar({|i|i=2**i;Formant.ar(*{|j|j+5.5**a.ar(j+0.75/i).lag(0.12)+a.ar(1.3/i,1/3)*99}!3)*a.ar(4/i)}!8).tanh}// #SuperCollider


// Apr 11, 2017
// https://twitter.com/redFrik/status/851842153345110017
// notes:
// audio rating:
// spectrograph rating:
play{a=Formant;Splay.ar(a.ar(a.ar(b=(1..12)/8,b/3.5+80,999-b/9)+3*50,a.ar(b/3,2.5,5)>0+1*300,a.ar(b/5,2,3)>0*1200)/3).tanh}// #SuperCollider


// Mar 09, 2017
// https://twitter.com/redFrik/status/839932733849751552
// notes:
// audio rating:
// spectrograph rating:
play{RecordBuf.ar(BPF.ar(Saw.ar((d=LFSaw.ar(1/9))>0+1/3*99)+c=GrainBuf.ar(2,d,24,b=LocalBuf(3e4).clear,-2),99,4).mean,b);c}// #SuperCollider


// Mar 08, 2017
// https://twitter.com/redFrik/status/839296011982024704
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;tanh(GrainFM.ar(1,a.ar([0.5,0.6]),16,a.ar(5)*a.ar(0.015)+1*98,round(2**a.ar(4),0.5)*99,2**a.ar(1/[8,9])*8)/2)}// #SuperCollider


// Feb 24, 2017
// https://twitter.com/redFrik/status/835174623000002560
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;b=(9..1)*4.0015;Splay ar:a.ar(0,a.ar(2/b)*3+4**a.ar(a.ar(b/8)/2+(a.ar(1/33)>0+8*b))*6,4**a.ar(1/b,b)).tanh/2}// #SuperCollider


// Feb 11, 2017
// https://twitter.com/redFrik/status/830540884043235328
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;Splay.ar({|i|Formant.ar(a.ar(i+1/150).round+1+i*99+a.ar([3,2]),b=i+2*99,b,a.ar(i+1/130).max(0)).tanh}!8)/3}// #SuperCollider


// Feb 04, 2017
// https://twitter.com/redFrik/status/828015533928935424
// notes: Philip Glass
// audio rating: *****
// spectrograph rating:
play{a=SinOscFB;AllpassN.ar(a.ar(2**(a.ar([4,3])>0)*(a.ar(1/16)>0+2*(a.ar(1/[32,48])>0*20+99)),a.ar(1/63.9)+2/3),3,3,60)/3}// #SuperCollider


// Jan 24, 2017
// https://twitter.com/redFrik/status/824007346036887553
// notes:
// audio rating:
// spectrograph rating:
play{Ringz.ar(c=Spring.ar(TDuty ar:Dseq(b=[3,3,2,2,2,1,2,2,2]/3,inf))/9,50*Duty.ar(c+1/[6,3],0,Dseq(c.lag>0+[2,4]/b,inf)))}// #SuperCollider


// Jan 18, 2017
// https://twitter.com/redFrik/status/821819178533449728
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;GVerb.ar(FreqShift.ar(c=a.ar([2,3]/8)%0.5,a.ar(1/[9,5]).round(c>0.125)+1*[3,2]*99).tanh/2,200,9,1,1,9,1,0.1)}// #SuperCollider


// Jan 18, 2017
// https://twitter.com/redFrik/status/821511865973014529
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;LocalOut ar:c=a.ar(99,LocalIn.ar(9)*a.ar((1..9)/99-98,0,a.ar(97/round(a.ar(1/32)+2.2).lag)*pi));Splay ar:c/2}// #SuperCollider


// Jan 15, 2017
// https://twitter.com/redFrik/status/820703970280767491
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;Splay ar:a.ar(Slope.ar(SinOscFB.ar((5..1)/2**a.ar(1/(5..9)+1,99*c=a.ar(1/(9..5))).round(1.005)*99,c+1/2)))/2}// #SuperCollider


// Jan 13, 2017
// https://twitter.com/redFrik/status/819981806820802560
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;a.ar(0,a.ar(99,9**a.ar(1/8,lagud(a.ar(1/[2,12])<0*2**a.ar(a.ar(3)>0*150),1/50,1/5)*5))+a.ar(1/[6,7]),3).tanh}// #SuperCollider


// Jan 11, 2017
// https://twitter.com/redFrik/status/819298955452416001
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;Splay ar:CombC.ar(a.ar(2**a.ar(1/6**(1..6))*99)*Decay.ar(HPZ1.ar(a.ar(#[2,3])<0),c=a.ar(98)%1/3),2,c.lag+1,6)}// #SuperCollider


// Jan 09, 2017
// https://twitter.com/redFrik/status/818548200281874432
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;Out.kr(8,c=a.ar(1/4)>0*a.ar(3/4,1,99,199).round(20)+DelayN.ar(In kr:[9,8],2,2)%[72,64]);a.ar(c**2,c.lag%1)}// #SuperCollider


// Jan 07, 2017
// https://twitter.com/redFrik/status/817851395537829888
// notes:
// audio rating:
// spectrograph rating:
play{Splay ar:HPF.ar(BLowPass.ar(LFTri ar:c=[1,3,5,6],Duty.ar(c+1/16,0,Dseq(LFTri.ar(1/c/8)>0*3+c*99,inf)),1e-3)/12,9).sin}// #SuperCollider


// Jan 02, 2017
// https://twitter.com/redFrik/status/815949778953654273
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;Splay ar:a.ar(b=(1..7)/7,a.ar(b/77)+1*7**a.ar(777*b,77**a.ar(b+a.ar(b/77,a.ar(b)/7,77*a.ar(b/77,b,b*7)))))/2}// #SuperCollider


// Dec 28, 2016
// https://twitter.com/redFrik/status/814225890141995008
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;Splay ar:a.ar(midicps(c=a.ar(12.fib/round(a.ar(1/[2,4])%1+0.125),1)>0*[9,2,3,0,7,5]+55),a.ar(c/999)+1/2)/3}// #SuperCollider


// Dec 14, 2016
// https://twitter.com/redFrik/status/809057768854392832
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;c=a.ar(b=(1..6)*60,LocalIn.ar(6)*3);LocalOut.ar(Limiter.ar(BPF.ar(c,a.ar(16/b)+3*b),0.66,16/b));Splay ar:c/2}// #SuperCollider


// Dec 03, 2016
// https://twitter.com/redFrik/status/805144743340572674
// notes:
// audio rating:
// spectrograph rating:
play{a=VarSaw;Splay ar:CombC.ar(a.ar(a.ar(1/b=[2,4,9,3]*9)>0+3*b,0,lag(a.ar(b/2e3)+1/2,1)),1.1,round(a.ar(8/b)%1)+0.1,8)/3}// #SuperCollider


// Nov 24, 2016
// https://twitter.com/redFrik/status/801856147821105153
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;Splay ar:a.ar(collect(b=(1..8),{|x,i|[x,i+6/6e3+x]})*60,c=a.ar(b/16/16.16)%1,a.ar([3,6],1,c.lag/3).max(0))}// #SuperCollider


// Nov 17, 2016
// https://twitter.com/redFrik/status/799342580144029696
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;Splay.ar(a.ar(13*13*b=(1..3),1/3)*a.ar(b/13,1)/13+a.ar(a.ar(1/(13..3))+133*b,a.ar(b/333,a.ar(b,1)%1)%1))/3}// #SuperCollider


// Nov 06, 2016
// https://twitter.com/redFrik/status/795347549037137920
// notes:
// audio rating:
// spectrograph rating:
play{a=VarSaw;Splay ar:a.ar(Select.ar(a.ar(2.01/b=[0,3,7,5,2,9,10]+0.2)*8,(c=a.ar(0.5/b))>0*12+b+48).midicps,0,c%1).tanh/2}// #SuperCollider


// Nov 05, 2016
// https://twitter.com/redFrik/status/795050413326299140
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Formlet.ar(Formlet.ar(a.ar(a.ar(c=a.ar([1,2]/32)<0+1)>0+c.lag(c)*99),0,a.ar(3-c/[4,3])+1).sin,99,0,0.01).tanh}// #SuperCollider


// Oct 30, 2016
// https://twitter.com/redFrik/status/792855763458912256
// notes:
// audio rating:
// spectrograph rating:
play{a=Blip;b=(1..8);Splay.ar(a.ar(a.ar(3.125,b)+a.ar(b/2.45,b)+1*a.ar(8/b,50)+1*99,a.ar(b/pi,b)+b-a.ar(1/4/b,2,4)).sin/2)}// #SuperCollider


// Oct 04, 2016
// https://twitter.com/redFrik/status/783388890610753536
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;b=AllpassC;b.ar(b.ar(a.ar(a.ar(0.1)<0/2+1*[99,98],a.ar(3e-3)+1/2),2,a.ar(0.9)/2+1,9),2,a.ar(0.91)/2+1,9)/4}// #SuperCollider


// Oct 02, 2016
// https://twitter.com/redFrik/status/782701827447984129
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;CombN.ar(a.ar(Duty.ar(c=[4,2]/(a.ar([4,1])>0*4+4),0,Dseries()%a.ar(c,c,42)+1*99).lag3(0.025).max(0)),2,2,4)/2}// #SuperCollider


// Sep 09, 2016
// https://twitter.com/redFrik/status/774348130066235392
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;Pluck.ar(a.ar(99+b=[1,2],1),a.ar(8),1,a.ar(b/16)>0/2+2.5-b/99+(b*a.ar(b,1)>(c=3e-3)/2),2,a.ar(c*b,0.4))/12}// #SuperCollider


// Sep 08, 2016
// https://twitter.com/redFrik/status/774033901924732928
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;AllpassC.ar(a.ar(a.ar(8)+3<<a.ar(3/8,0.9,a.ar(5)+1,4.2)*9,a.ar(1/32)+a.ar(7.9,1)),2,a.ar([3,2]/999)+1,4)/2}// #SuperCollider


// Aug 26, 2016
// https://twitter.com/redFrik/status/769282504452898816
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;LocalOut ar:c=a.ar(Duty.ar(Trig.ar(LocalIn ar:2,a.ar(b=1/[3,2])+11/2),0,Dseq((1..8),inf))*99,a.ar(b/12));c}// #SuperCollider


// Aug 23, 2016
// https://twitter.com/redFrik/status/768175056518283264
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;GVerb.ar(mean(FreqShift.ar(c=a.ar(a.ar(a.ar(99/b=(1..9),1),1/b)+b*50,1),1/b)+c)/3,200,3,0.5,0.5,9,1,0.7,1)}// #SuperCollider


// Aug 22, 2016
// https://twitter.com/redFrik/status/767860341652987904
// notes:
// audio rating:
// spectrograph rating:
play{FreqShift.ar(a=Splay.ar(Formlet.ar(Blip.ar(Blip.ar(Blip.ar(2.01,3)>0,b=(1..9))+1,b/8)+2*99,b*50,0.01).tanh),0.01)+a/7}// #SuperCollider


// Aug 19, 2016
// https://twitter.com/redFrik/status/766760494535479300
// notes:
// audio rating:
// spectrograph rating:
play{CombN.ar(Blip.ar(Duty.ar(1/[9,8],0,Dseq(\AVVVF.ascii.midicps,inf)/a=2+Blip.ar(3/[8,9],2).round),c=a**a.lag,c+5)).tanh}// #SuperCollider


// Aug 17, 2016
// https://twitter.com/redFrik/status/765938782067720193
// notes:
// audio rating:
// spectrograph rating:
play{HPF.ar(FreeVerb.ar({|i|SinOsc.ar(Duty.ar(i+1/9,0,Dseq((1..8).stutter(32),inf)*Dseq(8.fib,inf)*99))}!2,0.2,1,0.2),9)/2}// #SuperCollider


// Aug 16, 2016
// https://twitter.com/redFrik/status/765686623560429568
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;Splay ar:a.ar(Duty.ar(1/b=(2..6),0,Dseq(a.ar(0.1)>0*b+ceil(b*a.ar(3/b))%14*99,inf)),b*b*tanh(a.ar(4/b)*9)|1)}// #SuperCollider


// Aug 05, 2016
// https://twitter.com/redFrik/status/761529564900237312
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;GVerb.ar(sum(RHPF.ar(a.ar(3.5-b=(8..2),a.ar(4/b)*99)>0*a.ar(b*99)*(9-b),a.ar(1/b/2)+2*666,0.4)).tanh/5,99,2)}// #SuperCollider


// Jul 31, 2016
// https://twitter.com/redFrik/status/759856446527926272
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;LocalOut kr:d=a.ar(Duty.kr(LocalIn kr:8,a.kr(1/16,1),Dseq((1..8)*50,inf)),a.kr(1/(1..8))+1/2);Splay ar:d/2}// #SuperCollider


// Jul 17, 2016
// https://twitter.com/redFrik/status/754796037085298688
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;b=Spring;c=a.ar((4..2)/64)%1;CombN ar:a.ar(0,b.ar(b.ar(b.ar(a.ar([2,3])>0,4,c@0/4),9,c@1/3),24,c@2/3)*9)*0.7}// #SuperCollider


// Jul 02, 2016
// https://twitter.com/redFrik/status/749246949505785857
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;Splay ar:CombN.ar(a.ar(Out.kr(0,b={|i|Duty.kr(i+1/9,0,In.kr(i+1%4)+Dseq(8.fib,inf)%9)}!4);b*99,b*2),1,1/3)/2}// #SuperCollider


// Jun 28, 2016
// https://twitter.com/redFrik/status/747728333392183296
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;b=Formant;b.ar(round(a.ar(1/16),c=3**a.ar([2,3],[0,1]))+3*33*ceil(c),3**c.lag*66,3**c*99)+b.ar(c+3,1-c*3e3)/4}// #SuperCollider


// Jun 27, 2016
// https://twitter.com/redFrik/status/747561799373955072
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;b=Formant;b.ar(round(a.ar(1/16),c=3**a.ar([2,3],[0,1]))+3*33*ceil(c),3**c.lag*66,3**c*99)*b.ar(c+3,1-c*3e3)/4}// #SuperCollider


// Jun 26, 2016
// https://twitter.com/redFrik/status/747173223192793089
// notes:
// audio rating:
// spectrograph rating:
play{b=XFade2;a=SinOscFB;a.ar(b.ar(a.ar(1).ceil*36,a.ar(2).round*2+4*12,a.ar(1/[4,12]))+8*4,c=a.ar([2,3])%1,c*a.ar(1,1/3))}// #SuperCollider


// Jun 15, 2016
// https://twitter.com/redFrik/status/743024591988264960
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;Splay.ar({|i|a.ar(1+(c=a.ar(i+1/[6,4])/(a.ar(1/[8,9])+1.5))**i+i*99,d=c%DelayN.ar(c),d.lag3(c%1/99))}!4)/3}// #SuperCollider


// Jun 07, 2016
// https://twitter.com/redFrik/status/740142783277748226
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;HPF.ar(CombN.ar(a.ar(sum({|i|a.ar(2**(1/8)**i,i/8,a.ar(i+8/8))>a.ar(i+[2,3]/88)}!8)*88,a.ar(1/18,1))),8)/3}// #SuperCollider


// May 30, 2016
// https://twitter.com/redFrik/status/737427869664739328
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;AllpassC.ar(HPF.ar(reduce(a.ar([600,500,99,50,8/3])*a.ar(0.1/(9..5)),\hypot)/2,9),1,a.ar(1/[80,90])/3+0.5,5)}// #SuperCollider


// May 30, 2016
// https://twitter.com/redFrik/status/737278629080662016
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;Mix(a.ar({|x|a.ar(x+1/[6,8]).round/2+1*99*{|x|Duty.kr(1/x,0,Dseq(fib(x+1)-1,inf))}.(x+2).lag(0.02)}!8)).tanh}// #SuperCollider


// May 29, 2016
// https://twitter.com/redFrik/status/736894773966077952
// notes:
// audio rating:
// spectrograph rating:
fork{(f={|a|play{Pan2.ar(SinOscFB.ar(Duty.kr(d=1/i=a@0,0,Dseq(a*99/2),2),b=Saw.kr(i))/5,b)};2.wait;f.(a+3/d%9)}).((4..12))}// #SuperCollider


// May 27, 2016
// https://twitter.com/redFrik/status/736247457236017152
// notes:
// audio rating:
// spectrograph rating:
play{a=Saw;RecordBuf.ar(a.ar(d=[2,4,8,3,6])%a.ar(9)/6,b=LocalBuf(3e3,5).clear);Splay.ar(Shaper.ar(b,a.ar(d*32+a.ar(d/8))))}// #SuperCollider


// May 17, 2016
// https://twitter.com/redFrik/status/732705334549184512
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Pluck.ar(a.ar(a.ar(1/16)+2*99,0,a.ar([2,3]/4)*6).sin,a.ar([6,4])%a.ar([4,6]),1,a.ar(5/[4,6])%(1/[2,3]),2)/9%1}// #SuperCollider


// May 14, 2016
// https://twitter.com/redFrik/status/731568482874236932
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;AllpassC.ar(a.ar(b=[99,98],c=a.ar(12))+a.ar(c>0*8*b,0,a.ar(1/b)),1,a.ar(1/[3,4])%1,8,a.ar(1/64,[0,1])*3).sin}// #SuperCollider


// May 13, 2016
// https://twitter.com/redFrik/status/731133437390794752
// notes:
// audio rating:
// spectrograph rating:
play{GVerb.ar(sum(SinOscFB.ar(33*b=(1..50),lagud(t=Impulse.ar(b/49),5e-3,0.2)*99,t.lagud(7e-3,1))),299,9,0.01,0.5,6,1,1,1)}// #SuperCollider


// May 09, 2016
// https://twitter.com/redFrik/status/729631900478902272
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;Splay.ar(a.ar(SelectX.ar(a.ar(0.1)%(a.ar(b=(1..4)))*(c=b+8),DC ar:':.UODD.Ed'.ascii.midicps),a.ar(1/c)))/2}// #SuperCollider


// May 09, 2016
// https://twitter.com/redFrik/status/729585004888653824
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;HPF.ar(Splay.ar(Saw.ar(midicps(':>AEH.'.ascii-ceil(2**a.ar((1..5)/32))))%a.ar(1!2++6)%a.ar(2,[1,2]/8,2)),9)/2}// #SuperCollider


// May 08, 2016
// https://twitter.com/redFrik/status/729396802357739524
// notes:
// audio rating:
// spectrograph rating:
play{a=Blip;GVerb.ar(HPF.ar(a.ar(a.ar(1/4,8).ceil+1*[99,9])*a.ar(1.01,ceil(2**a.ar(1/16)*4))>(a.ar(1/128)/4),9)/9,9,2,0.9)}// #SuperCollider


// May 04, 2016
// https://twitter.com/redFrik/status/727992849527083009
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;a.ar((b=a.ar(1/3))+1**a.ar(b)*(99+c=[0,1]))%a.ar(b*99,c)%a.ar(1/32)+a.ar(a.ar(b)*4e4%2e3,0,a.ar(6,c)>0.9/2)/2}// #SuperCollider


// Apr 29, 2016
// https://twitter.com/redFrik/status/726070632295845889
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;RHPF.ar(Splay ar:SinOsc.ar(a.ar(c=[6,14,4])%a.ar(c),a.ar(c-1)+1**a.ar(c/9)*4,a.ar(1/c)>0*99),99,0.3).tanh*0.6}// #SuperCollider


// Apr 18, 2016
// https://twitter.com/redFrik/status/722168685255921664
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;Splay.ar(a.ar(a.ar(b=1/(2..6),1)<b*500+99)/5+a.ar(999*b,a.ar(a.ar(b,1)<0.1+1,1)%b,a.ar(0.1-b,1).min(0)))/2}// #SuperCollider


// Apr 18, 2016
// https://twitter.com/redFrik/status/721993879935971329
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;Splay.ar(AllpassN.ar(a.ar(999*b=1/(a.ar(1/(4..9))>0*[1,4,2,3]+4),a.ar(a.ar(b)>0,b,b)%1).tanh/2,1,b.lag,4))}// #SuperCollider


// Mar 24, 2016
// https://twitter.com/redFrik/status/713092653378834437
// notes:
// audio rating:
// spectrograph rating:
play{a=LFCub;Splay.ar(a.ar(b=2/(2..9))%a.ar(b/5)*a.ar(2**a.ar(b/8)>0+1*2*(b*[300,303]-(a.ar(b/9)>0*50).lag2))*a.ar(b/6,b))}// #SuperCollider


// Mar 18, 2016
// https://twitter.com/redFrik/status/710894934065324032
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;Splay.ar(FBSineC.ar(2**a.ar(pi/b=7.fib).ceil*99*(2**b)%((c=a.ar(b/99)+1)*4e3),c+0.1,a.ar(1/b/20)+1,1.02,7)/3)}// #SuperCollider


// Mar 11, 2016
// https://twitter.com/redFrik/status/708428560365703168
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Splay ar:a.ar(CombN ar:DegreeToKey.ar(as(b=[1,3,6,8,10],LocalBuf),a.ar(a.ar(1/b/99)/pi)*12+18+b).midicps)*0.6}// #SuperCollider


// Mar 11, 2016
// https://twitter.com/redFrik/status/708396280318402560
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Splay ar:RLPF.ar(a.ar(a.ar(b=1/2**(2..6))>0*3+15/b),pi**a.ar(a.ar(b)+1*b)*999+(a.ar(a.ar(b*9)*9)*99)/2,0.2)/5}// #SuperCollider


// Mar 10, 2016
// https://twitter.com/redFrik/status/708070394348105728
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;Splay.ar(Blip.ar([60,65,53,67,80].midicps,(b=(1..5))**ModDif.ar(a.ar(1),a.ar(2),a.ar(4))*a.ar(1/b/9)*9)).tanh}// #SuperCollider


// Mar 04, 2016
// https://twitter.com/redFrik/status/705564306646159360
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;VOsc3.ar({|i|Buffer.alloc(s,1024).sine1(i+c=(3..1))}!2@0,*c+round(d=a.ar([2,[3,1]]))*(a.ar(d*5)>0)/2*99).tanh}// #SuperCollider


// Feb 20, 2016
// https://twitter.com/redFrik/status/701161033633808391
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;CombN.ar(a.ar(a.ar(a.ar(1/[2,3])<0+1)**a.ar(1+a.ar(1+a.ar(1/6)*99)*666).lag(a.ar([1.55,1])%1)*99),1,0.9,3)/3}// #SuperCollider


// Feb 19, 2016
// https://twitter.com/redFrik/status/700706716866904064
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;HPF.ar((c=Splay.ar(a.ar(b=(19..-9)*50.01)*(1.2**a.ar((1..5)*3/4*(a.ar(1/b).floor*3+1)))&b)%1)+a.ar(9/c),9)/3}// #SuperCollider


// Feb 12, 2016
// https://twitter.com/redFrik/status/698273948610523137
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;HPF.ar(Splay ar:a.ar(TwoPole.ar(a.ar(2**b=(3..8)*(a.ar(0.05).round/4+1))>c=a.ar(1.1/b),b*99,c%0.5+0.5))/2,9)}// #SuperCollider


// Jan 26, 2016
// https://twitter.com/redFrik/status/692094504749420545
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;b=(a.ar(c=0.015)/9<a.ar(5/(1..7))).varlag(c);Splay.ar(a.ar(2-b**ceil(a.ar(b)*5+6),b)+BrownNoise.ar(b%1)).sin}// #SuperCollider


// Jan 26, 2016
// https://twitter.com/redFrik/status/691974182846988289
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;AllpassN.ar(a.ar(98.5+c=(Amplitude.ar(d=InFeedback.ar)<a.ar(f=1/[9,8.9])).lag(f/9)+d,d+f,c),1,f*3,20).tanh}// #SuperCollider


// Jan 26, 2016
// https://twitter.com/redFrik/status/691949017891278848
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;b=a.ar(5/(1..5)).ceil.lag(c=a.ar(5e-3)%0.05);Splay.ar(a.ar(5**b*((5..1)*50),c*b*5555,1+a.ar(1/50+c)-b)).tanh}// #SuperCollider


// Jan 10, 2016
// https://twitter.com/redFrik/status/686298327449640960
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Splay.ar((c=Resonz.ar(a.ar(50.1/b=1/(1..8)),500*d=2**a.ar(b/9),a.ar(-4*b)%1))+PitchShift.ar(c,b,d round:b))/2}// #SuperCollider


// Jan 09, 2016
// https://twitter.com/redFrik/status/685614952988721152
// notes:
// audio rating:
// spectrograph rating:
play{a=Blip;z=sum(a.ar(b=9/(1..9),303)*a.ar(b/5-4,2.5));{|i|z=z+AllpassC.ar(z,1,i+1/b/9,a.ar(b/9,2),b/9)}!9;Splay ar:z.sin}// #SuperCollider


// Dec 24, 2015
// https://twitter.com/redFrik/status/680011348869251072
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;(d=Splay.ar(a.ar(c=a.ar(b=(1..6)/2).div(4/b)+(e=a.ar(b/99)*2+3).round*99)).sin)+a.ar(c*1.5,e/d,0.7/e).mean/2}// #SuperCollider


// Dec 19, 2015
// https://twitter.com/redFrik/status/678145805769945089
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;Splay.ar(a.ar(1/99)*sin(LPF.ar(Pulse.ar(2,a.ar(b=a.ar(1e-4)+1/(8..2))),500,a.ar(b/3)+1*8))%sin(a.ar(4))).tanh}// #SuperCollider


// Dec 18, 2015
// https://twitter.com/redFrik/status/677888256751624192
// notes: phasing
// audio rating:
// spectrograph rating:
play{a=Saw;GVerb.ar(a.ar(25*b=(8..2))).mean.lag2(c=LFSaw.ar(a.ar([33,99])+2)+1/99)+mean(a.ar(8/b,a.ar(b))|a.ar(c+2)).sin/3}// #SuperCollider


// Dec 14, 2015
// https://twitter.com/redFrik/status/676520296023764992
// notes: merzbow, awful noise
// audio rating: *
// spectrograph rating:
play{a=LFSaw;SelectXFocus.ar(a.ar([9,99]*c=a.ar(9**a.ar(9)*99))*9,a.ar(Sweep.ar(a.ar((1..9)),c)*9e4%9e2),a.ar(1/9)/9).tanh}// #SuperCollider


// Dec 11, 2015
// https://twitter.com/redFrik/status/675329084948414464
// notes: cool bouncy metallic
// audio rating: ****
// spectrograph rating:
play{a=SinOsc;c=Decay2;CombN ar:a.ar(a.ar(b=(1..6)).sum*9+99,sum(c.ar(t=a.ar(10/b).sum>[1,2]*a.ar)*b),c.ar(t,0.02,0.2))/20}// #SuperCollider


// Dec 09, 2015
// https://twitter.com/redFrik/status/674562018544852992
// notes: 8-bit squares
// audio rating: ****
// spectrograph rating: ****
play{a=LFPulse;CombN.ar(Splay.ar(a.ar(a.ar([1,3])+a.ar(1/[20,30])+a.ar(1/b=[8,9])+a.ar(a.ar(1/12,1/3)*99*b)*(1..5)*50)/2))}// #SuperCollider


// Dec 03, 2015
// https://twitter.com/redFrik/status/672539880090673153
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;Splay.ar(lag(a.ar(b=RotateN.ar(a.ar(a.ar(a.ar(1/9)>0))*99,DC ar:(1..6)))>a.ar(b/8))*a.ar(b*99)%a.ar(b/99,b))}// #SuperCollider


// Dec 02, 2015
// https://twitter.com/redFrik/status/671863663645630464
// notes:
// audio rating:
// spectrograph rating:
play{a=Blip;a.ar(c=a.ar(9.87,6/5,4,[3,2])>a.ar(8/76,5/432,a.ar([7,6],5.4,3,2),1))*a.ar(a.ar(6,5,4,3),2)>a.ar([5,4],3210/c)}// #SuperCollider


// Dec 01, 2015
// https://twitter.com/redFrik/status/671836988618706944
// notes: liquid in tubes, borborygmi, spectrograph has arches
// audio rating: ***
// spectrograph rating: *****
play{a=Blip;a.ar(c=a.ar(a.ar(1.23,4.5),6,7,8.9)+a.ar(0.123,[4,5],67,8))*a.ar(a.ar(1,[2,3],4,5),6)+a.ar([7,8]*9,1/c*23.4)/5}// #SuperCollider


// Nov 24, 2015
// https://twitter.com/redFrik/status/669284151271530496
// notes: rhythmic
// audio rating: ****
// spectrograph rating:
play{a=LFSaw;(c=HPF.ar(a.ar(b=1/16)+a.ar(b/4)+a.ar(b/3)*9|(e=a.ar(b,d=[0,1])*99),9,e/9).sin)+PitchShift.ar(c,b,e>>5%2+1)/3}// #SuperCollider


// Nov 24, 2015
// https://twitter.com/redFrik/status/669163705100292097
// notes: rhythmic, in 9 (4 and 5)
// audio rating: ****
// spectrograph rating:
play{a=VarSaw;CombN.ar(tanh(a.ar(99*b=[6,9])*3+a.ar(a.ar(0.39/b)>0+1*50,0,a.ar(1/27),a.ar(1/3)*18)+(a.ar(3)>0*9)),1,1,4)/2}// #SuperCollider


// Nov 23, 2015
// https://twitter.com/redFrik/status/668905786991624200
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;c=a.ar|a.ar(1,[0,a ar:1e-4],2);Splay ar:HPF.ar(c+CombC.ar(RLPF.ar(c,b=12.fib*112,0.01),3,a.ar(2/b)+2,5)/4,9)}// #SuperCollider


// Nov 23, 2015
// https://twitter.com/redFrik/status/668845370328358912
// notes:
// audio rating:
// spectrograph rating:
r{inf.do{|i|play{MoogFF.ar(SyncSaw.ar([7,8],[5,10,12,20,24]*10@@(i*2)),4e3*e=Line.ar(0,pi,10,1,0,2).sin)*e/3};1.wait}}.play// #SuperCollider


// Nov 22, 2015
// https://twitter.com/redFrik/status/668462430855569408
// notes:
// audio rating:
// spectrograph rating:
play{a=SyncSaw;GVerb.ar(Limiter.ar(HPF.ar(Mix(a.ar(99*b=(1..8),b*2.01)%a.ar(b/64,a.ar([4,8,14],b/4)+1).max(0)),9))/2,70,4)}// #SuperCollider


// Nov 10, 2015
// https://twitter.com/redFrik/status/664194702447636480
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;AllpassC.ar(Mix(a.ar(Latch.ar(a.ar(1.50055,[0,5e-4]!2),a.ar([15,4,2]))*[999,400,150]))/4,3,2-a.ar(0.1,[0,1]))}// #SuperCollider


// Nov 10, 2015
// https://twitter.com/redFrik/status/664078296280408065
// notes: klaxon and alarm. Be an  amazing intro
// audio rating:
// spectrograph rating:
play{a=Blip;b=a.ar([6,5]/2).round(a.ar(1.01))%1;HPF.ar(b+AllpassC.ar(PitchShift.ar(b,1,2,c=0.03),2,a.ar(c,[2,3])/2+1,3),9)}// #SuperCollider


// Nov 05, 2015
// https://twitter.com/redFrik/status/662412028959657984
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;Splay.ar(a.ar((b=(d=a.ar(0.1)<0)+(2..8)/(d+2))*99)+Ringz.ar(a.ar(b/2)>0,b*99,5**a.ar(a.ar(0.01)+2-b)/4)).tanh}// #SuperCollider


// Sep 29, 2015
// https://twitter.com/redFrik/status/649006541237002240
// notes: vandenberg, surface of the sun, noise
// audio rating: *****
// spectrograph rating: *****
r{inf.do{|i|j=i.div(100)+1;x={Splay.ar(Blip.ar(i*j%(99..96)+1,i*j%(98..95)+1))*5}.play(s,0,6);0.12.wait;x.release(8)}}.play// #SuperCollider


// Sep 23, 2015
// https://twitter.com/redFrik/status/646712633979219968
// notes:
// audio rating:
// spectrograph rating:
play{a=LFPulse;CombC.ar(DynKlank.ar(`[midicps(a.ar(1/b=(1..9)*1.5)*b+50),2e-4,b/9],e=a.ar(d=[2,3]/.t b)),2,2-LPF.ar(e,50))}// #SuperCollider


// Sep 05, 2015
// https://twitter.com/redFrik/status/640227948885319680
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Pan2.ar(AllpassC.ar(a.ar(1/c=(1..9))>0.9*a.ar((d=a.ar(0.075))>0/3+1*c*99),1,c/9,d*4+4),a.ar(1/c/9)).sum.lag*8}// #SuperCollider


// Sep 03, 2015
// https://twitter.com/redFrik/status/639559946724638721
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw ar:_;sum({|i|Pan2.ar(a.(a.(i+1/99)/9+1.25**i*9+99),a.(i+1/98))}!23)/6+LPF.ar(a.(a.(0.009)*9)>0*a.([50,51]))/4}// #SuperCollider


// Sep 03, 2015
// https://twitter.com/redFrik/status/639424695192915968
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Splay.ar(a.ar((c=(1..9)/8)**a.ar(c,c,1,a.ar(0.21)%1).reduce('bitXor')*Duty.ar(4,0,Dseq([33,10,40]*9,inf))))/4}// #SuperCollider


// Sep 03, 2015
// https://twitter.com/redFrik/status/639424695192915968
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Splay.ar(a.ar((c=(1..9)/8)**a.ar(c,c,1,a.ar(0.21)%1).reduce('bitXor')*Duty.ar(4,0,Dseq([33,10,40]*9,inf))))/4}// #SuperCollider


// Jul 19, 2015
// https://twitter.com/redFrik/status/622860814614163457
// notes: bubbles
// audio rating:
// spectrograph rating:
play{a=LFCub;Splay.ar(Limiter.ar(Formlet.ar(Logistic.ar(3.9,b=(7..4)),a.ar(b)+a.ar(b/7)*800+999,c=a.ar(b/99)%1/50,c*2)/9))}// #SuperCollider


// Jul 10, 2015
// https://twitter.com/redFrik/status/619517949334945792
// notes:
// audio rating:
// spectrograph rating:
r{inf.do{|i|a=play{Duty.ar(3e-3*[b=i%99/99,1-b],0,Dseq(i.asInt.asDigits(2,8),8))*Saw.ar(99+[b,0])/2};0.2.wait;a.free}}.play// #SuperCollider


// Jul 04, 2015
// https://twitter.com/redFrik/status/617334280612659200
// notes: industrial
// audio rating:
// spectrograph rating:
play{a=LFTri;BufWr.ar(e=a.ar(12/c=1/(9..5)),b=LocalBuf(4e4,5).clear,a.ar(e%c)*1e5,0);Splay.ar(BufRd.ar(5,b,a.ar(1)*1e4,0))}// #SuperCollider


// Jul 01, 2015
// https://twitter.com/redFrik/status/616363552182550528
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;Splay.ar(a.ar(CompanderD.ar(Duty.ar(c=a.ar(b=(1,3..13),b,b,b),0,Dseq(b,inf)),5,4,3,c)*99,a.ar(b*9)*9,2)).sin}// #SuperCollider


// Jun 28, 2015
// https://twitter.com/redFrik/status/615248501044310016
// notes: keith emerson
// audio rating:
// spectrograph rating:
play{a=LFPulse;Splay.ar(a.ar((99*b=[1,4,5,8])*lag(a.ar(a.ar(4/b)+a.ar(9-b/9)*50))+b)/2)+Mix(GrayNoise.ar(a.ar(b,0,0.1))/9)}// #SuperCollider


// Jun 27, 2015
// https://twitter.com/redFrik/status/614943252215648258
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;Splay.ar(a.ar(Duty.ar(b=1/[1,4,6,8,11],c=a.kr(b/98),Dseq(Select.kr(a.kr(b/99)+c*5,1/b+59),inf).midicps)+c)/2)}// #SuperCollider


// Jun 23, 2015
// https://twitter.com/redFrik/status/613423065448480768
// notes: descending bells, trippy
// audio rating:
// spectrograph rating:
a=SinOsc;play{CombC.ar(a.ar(Duty.ar(1/b=[4,3],0,Dseq(9.fib.pyramid*99,inf)))*a.ar(b/9),1.01,a.ar(b/999).abs+0.01,9).tanh/2}// #SuperCollider


// May 10, 2015
// https://twitter.com/redFrik/status/597390902227787776
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Splay.ar(Pluck.ar(a.ar(30*c=(5..7))*a.ar(b=1/[25,14]),a.ar([3,2]),0.02,a.ar(c/66)+1/7,9,a.ar(1/c)%1,3).sin)/2}// #SuperCollider


// May 06, 2015
// https://twitter.com/redFrik/status/596051297444433920
// notes: decaying sitar
// audio rating:
// spectrograph rating:
play{Splay.ar(CombC.ar(PinkNoise.ar(Ringz.ar(LFSaw.ar(b=(1..9)/16),b*999,1.25)),1,1/(b*999)*(LFTri.ar(b/120,b*2)%1),3))/99}// #SuperCollider


// Apr 29, 2015
// https://twitter.com/redFrik/status/593371123263381505
// notes: groovy atari 2600
// audio rating:
// spectrograph rating:
play{a=LFPulse;b=(1..9);Splay.ar(CombN.ar(a.ar(b*99*a.ar(b)).reduce('&'),2,2/b,2))+BPF.ar(a.ar(4)*4,a.ar(2)+[1,2]*99,0.12)}// #SuperCollider


// Mar 29, 2015
// https://twitter.com/redFrik/status/582277939653439489
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Splay ar:HPF.ar(MoogFF.ar(a.ar(50*b=(0.999..9))-Blip.ar(a.ar(b)+9,b*99,9),a.ar(b/8)+1*999,a.ar(b/9)+1*2),9)/3}// #SuperCollider


// Mar 12, 2015
// https://twitter.com/redFrik/status/576155047513452544
// notes: cool 3/4 or 12/8 thing
// audio rating: *****
// spectrograph rating: ****
play{a=LFPulse;f=SinOsc;b=a.ar(a.ar(4/3)*4).lag2(0.01);Splay.ar(f.ar(d=lag(99**b*a.ar(c=2/(6..9))))+f.ar(d*b/c,b*d,1-c))/4}// #SuperCollider


// Dec 03, 2014
// https://twitter.com/redFrik/status/539965021896601601
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;LocalOut.ar(b=a.ar(0.5,Peak.ar(c=LocalIn ar:2,d=a.ar(9/[2,3]))*a.ar(5e-3)*9));HPF.ar(b+a.ar(0,d.max+c*99),9)}// #SuperCollider


// Sep 19, 2014
// https://twitter.com/redFrik/status/512944802908737537
// notes: trippy decaying bells, bad trip, depressing
// audio rating: ****
// spectrograph rating: ***
a=LFSaw;play{b=(1..8)*99;Splay.ar(CombN.ar(Blip.ar(b/2+a.kr(-8/b,1,99),b/4+a.kr(1/b,1,99))*SinOsc.ar(8/b,a.ar(99/b)))).sin}// #SuperCollider


// Sep 15, 2014
// https://twitter.com/redFrik/status/511646352645054464
// notes:
// audio rating:
// spectrograph rating:
a=SinOsc;play{d=BufRd.ar(2,b=LocalBuf(c=2e5,2).clear,a.ar([2,3]*9)*c,0);BufWr.ar(a.ar(3/[2,3])/3,b,a.ar([99,145]).abs*c);d}// #SuperCollider


// Sep 15, 2014
// https://twitter.com/redFrik/status/511593744635002881
// notes:
// audio rating:
// spectrograph rating:
a=LFSaw;play{Splay.ar(BPF.ar(a.ar(f=Duty.ar(a.ar(a.ar(c=3/d=(2..6)))*a.ar(d)/c,0,Dseq(ceil(a ar:d)+d*99,inf))+a.ar(c)),f))}// #SuperCollider


// Sep 14, 2014
// https://twitter.com/redFrik/status/511191188150697984
// notes:
// audio rating:
// spectrograph rating:
a=SinOscFB;play{((c=InFeedback.ar(0,2).lag(b=1/67))+DelayL.ar(HPF.ar(a.ar([99,98]*50.666*a.ar(c+b*b,c),c%2),50),b,b)).tanh}// #SuperCollider


// Sep 13, 2014
// https://twitter.com/redFrik/status/510913350503776256
// notes:
// audio rating:
// spectrograph rating:
a=SinOsc;play{tanh((c=InFeedback.ar(0,2))+HPF.ar(a.ar(b=1/[5,4],a.ar(a.ar(b*1.1,a.ar(b*2))+a.ar(b*1.4,c,5,4).ceil*99)),9))}// #SuperCollider


// Aug 10, 2014
// https://twitter.com/redFrik/status/498453934173081600
// notes:
// audio rating:
// spectrograph rating:
a=SinOsc;play{RecordBuf.ar(c=InFeedback.ar,b=Buffer.alloc(s,9e4));HPF.ar(a.ar(99,c*6)/9+TGrains.ar(2,a ar:3,b,c+3,2,12),9)}// #SuperCollider


// Apr 16, 2014
// https://twitter.com/redFrik/status/456384156159574016
// notes:
// audio rating:
// spectrograph rating:
a=SinOsc;play{Splay ar:a.ar(HPF.ar(Ringz.ar(a.ar(b=1/[3,12,4,1,6,2]).lag3(a.ar(2.67**b).abs)*99,a.ar(1/b/9,b)>0*20+99/b)))}// #SuperCollider


// Apr 15, 2014
// https://twitter.com/redFrik/status/456056385164562432
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;Splay.ar(a.ar(99*(b=a.ar(a.ar(c=1/(1..9))*9)>0.5)/2+Demand.ar(Stepper ar:b,0,Dseq(99/c,inf)).lag3+a.ar(c)))/2}// #SuperCollider


// Apr 14, 2014
// https://twitter.com/redFrik/status/455667775349207041
// notes:
// audio rating:
// spectrograph rating:
a=LFSaw;play{Splay.ar(BBandPass.ar(a.ar(3.7*b=1/(1..16),0,a.ar(99+b,0,a.ar(b*c=0.055).max)),4**a.ar(b/8)*99+99,c,20).tanh)}// #SuperCollider


// Apr 13, 2014
// https://twitter.com/redFrik/status/455441531571560449
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Mix(SinOsc.ar(3**Hasher.ar(round(a.ar(0.1)%1,c=(3..1)/16))*(a.ar(c,c)<0*[6,2,1]+[4,[5,5.05],3]*99))).softclip}// #SuperCollider


// Apr 13, 2014
// https://twitter.com/redFrik/status/455134785556709377
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;BufWr.ar(a.ar(1),b=LocalBuf(c=7e4).clear,a.ar(1.005)*c);Splay.ar(HPF.ar(BufRd.ar(1,b,a.ar([5,1,2,4])*c),9))/2}// #SuperCollider


// Apr 11, 2014
// https://twitter.com/redFrik/status/454598285861617665
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;c=a.ar(3**a.ar(1/b=(9..1),b/9));Splay.ar(GrainSin.ar(2,c,a.ar(1/b)%1/9+0.01,2**a.ar(b/99).round*99*b).tanh)/2}// #SuperCollider


// Apr 10, 2014
// https://twitter.com/redFrik/status/454207847577190400
// notes: cool 9/8-ish, swinging 3/4-y thing going on.
// audio rating: ****
// spectrograph rating:
a=LFPar;play{Splay.ar(GrainFM.ar(1,a.ar(9),a.ar((3..7))%1/9,a.ar(1/(2..8))%1*99,(1..9)*99,a.ar(0.22/(4..6))/2+0.5*9)).tanh}// #SuperCollider


// Apr 09, 2014
// https://twitter.com/redFrik/status/453845158275334144
// notes:
// audio rating:
// spectrograph rating:
play{{|i|RecordBuf.ar(Limiter.ar(HPF.ar(Warp1.ar(1,b=LocalBuf(9e3).clear,c=LFSaw.ar(d=1.0009,i).max,1/d)+(c>0/3),9)),b)}!2}// #SuperCollider


// Apr 08, 2014
// https://twitter.com/redFrik/status/453512108559581184
// notes:
// audio rating:
// spectrograph rating:
a=LFCub;play{RecordBuf.ar(InFeedback.ar+a.ar(99),b=Buffer.alloc(s,8e4));TGrains.ar(2,a ar:c=[3,2],b,a.ar(1/c)>0/2+1.5,0,3)}// #SuperCollider


// Apr 08, 2014
// https://twitter.com/redFrik/status/453326676110610432
// notes:
// audio rating:
// spectrograph rating:
a=SinOsc;play{a.ar(0,a.ar(5/3)%1+a.ar(Duty.ar(b=0.15,0,Dseq(a.ar(a.ar(b)/3+0.3).max+1*[[261,440],220,261,349,99,0],inf))))}// #SuperCollider


// Apr 06, 2014
// https://twitter.com/redFrik/status/452771460688646144
// notes:
// audio rating:
// spectrograph rating:
play{a=Blip;HPF.ar(Normalizer.ar(Splay.ar(Pluck.ar(a.ar(99*b=LFTri.ar(1/c=(1..9))>0+c,1).abs,a.ar(1/b,2).abs)),1,2e-3),12)}// #SuperCollider


// Apr 05, 2014
// https://twitter.com/redFrik/status/452481888410939392
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;Splay.ar(Formlet.ar(Blip.ar(a.ar(1/(1..9))*400+99,50),(11,22..66)++50++88*10,a.ar(3).abs,a.ar(pi).abs).clip)}// #SuperCollider


// Apr 04, 2014
// https://twitter.com/redFrik/status/452141124740997120
// notes:
// audio rating:
// spectrograph rating:
{|i|play{Normalizer.ar(Saw.ar(i+1*[48.9,49+LFTri.ar(1e-3,i/9,b=1/9)],2pi).sin*tanh(LFTri.ar(b/(i+1),0,2,1).max),b,1e-5)}}!9// #SuperCollider


// Apr 03, 2014
// https://twitter.com/redFrik/status/451711145871966208
// notes:
// audio rating:
// spectrograph rating:
a=Blip;play{Splay.ar(Formant.ar(a.ar(9/b=(1..9),a.ar(1/b,b)+2*99,b)+1*[99,400,999,50],a.ar(1/4/b,a.ar(0.2/b,b))*99*b)).sin}// #SuperCollider


// Apr 02, 2014
// https://twitter.com/redFrik/status/451267662027698176
// notes:
// audio rating:
// spectrograph rating:
a=(1,3..9)*99;fork{inf.do{play{SinOsc.ar(Duty.ar(1/[8,9],0,Dseq(a=wrap(a*9,99,8e3),99)),0,Line.kr(0.2,0,9,1,0,2))};2.wait}}// #SuperCollider


// Apr 01, 2014
// https://twitter.com/redFrik/status/451097014726836224
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;c=(2..22)*99;b=999/c;Splay.ar(MoogFF.ar(a.ar(b*99*a.ar(b*9*a.ar(a.ar(b/9)*b))),(d=a.ar(9/c,9/c))+2*c,d+2.99))}// #SuperCollider


// Mar 31, 2014
// https://twitter.com/redFrik/status/450692108199149569
// notes:
// audio rating:
// spectrograph rating:
{|i|play{a=LFPulse;HPF.ar(Ringz.ar(a.ar(a.ar(1/(j=i+1)+a.ar(b=(2..5),0,1/b)*b).sum+1*[89,99]*j),2**i*99,0.42).tanh,9)/5}}!4// #SuperCollider


// Mar 30, 2014
// https://twitter.com/redFrik/status/450405748087205888
// notes:
// audio rating:
// spectrograph rating:
a=SinOsc;fork{inf.do{|i|play{Pan2.ar(a.ar(i,a.ar(Duty.ar(b=0.1,0,Dseq([0,i%9,2,3,4,0,2,1]*150,9))),b),i%3-1)};wait(i%5+1)}}// #SuperCollider


// Mar 29, 2014
// https://twitter.com/redFrik/status/449991577898065920
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;HPF.ar(SinOsc.ar(2**Decay.ar(a.ar(c=[2,3]),b=2**a.ar(1/9)-0.5)+99))*BLowPass4.ar(a.ar([261,369]),b+1*5e3,0.2)}// #SuperCollider


// Mar 28, 2014
// https://twitter.com/redFrik/status/449687391411142656
// notes:
// audio rating:
// spectrograph rating:
a=SinOsc;{|i|play{Pan2.ar(a.ar(i+1/99,i+[1,2]+a.ar(i+1*999)*a.ar([50,74,99]@@i*a.ar(i/9+99,i,i,i))),a.ar(a.ar(i/9)))/11}}!9// #SuperCollider


// Mar 27, 2014
// https://twitter.com/redFrik/status/449314041442615298
// notes:
// audio rating:
// spectrograph rating:
play{Splay.ar({|i|SinOsc.ar(c=1/8,LFCub.ar(Duty.ar(b=InFeedback.ar(i%pi)+c,b-c,Dseq(midicps((1..9)*25%32+40),inf)))+i)}!9)}// #SuperCollider


// Mar 26, 2014
// https://twitter.com/redFrik/status/448830660330135552
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Splay.ar(Ringz.ar(CombN.ar(ClipNoise.ar(a.ar(b=(1..5)/8)>a.ar(0.1,0,1,0.5)),1,b,2),[261,311,349,391,466]))/90}// #SuperCollider


// Mar 25, 2014
// https://twitter.com/redFrik/status/448496913919516672
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;mean({|i|b=a.ar(a.ar(j=i+0.99)/9,a.ar(a.ar(j/99))*9,j*9).tanh;Pan2.ar(a.ar(b.exprange(j*99,j+1*99)+i),b)}!9)}// #SuperCollider


// Mar 24, 2014
// https://twitter.com/redFrik/status/448183491340304385
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;Normalizer.ar(Splay.ar(a.ar(811+b=(2..8),a.ar((c=a.ar(0.1/b,b))<0*9*b+855+(9/b),a.ar(899/b)*2,2).tanh*6,c)))}// #SuperCollider


// Mar 23, 2014
// https://twitter.com/redFrik/status/447738059497676800
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;tanh(a.ar(3e-3,DelayC.ar(Ringz.ar(b=InFeedback.ar(1),[9,12],a.ar(c=1/[3,4])+15),1,a.ar(0,b.lag3(1))/9+0.5)))}// #SuperCollider


// Mar 22, 2014
// https://twitter.com/redFrik/status/447312148109492224
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;b=(2,4..20);CombN.ar(Splay.ar(HPF.ar(a.ar(0,Duty.ar(2/b,0,Dseq(b,inf)).lag2(a.ar(1/b,b)%1)*2pi),9)),1,2/3,4)}// #SuperCollider


// Mar 21, 2014
// https://twitter.com/redFrik/status/447132914141384704
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Splay.ar(BLowPass4.ar(b=a.ar(a.ar(c=3/(1..12),d=c/3*2,99/c+99,900+c)),c*999+a.ar(c),a.ar(c,d)%1+0.01*2)).tanh}// #SuperCollider


// Mar 20, 2014
// https://twitter.com/redFrik/status/446787452653805568
// notes:
// audio rating:
// spectrograph rating:
play{a=Pulse;c=a.ar(b=[4,1,5,8,3],d=b/9).lag(1/b);Splay.ar(a.ar(b*99*a.ar(b,1/4,1,1.01)|a.ar(d,d,98,99).lag(c%1),c/2+0.5))}// #SuperCollider


// Mar 19, 2014
// https://twitter.com/redFrik/status/446237894437769216
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Splay.ar(CombN.ar(Blip.ar(a.ar(b=(1..5)).ceil*(a.ar(1/b)*30+60)+99,a.ar(0.2/b).round(1/3)*8+9).tanh,4,4/b,9))}// #SuperCollider


// Mar 18, 2014
// https://twitter.com/redFrik/status/445939927822635009
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri.ar(b=8/(1..11))%(LFTri.ar(b-3))+2.01;Limiter.ar(Splay.ar(Formant.ar(202*a[0..3],404*a[4..7],606*a[8..11])))/2}// #SuperCollider


// Mar 18, 2014
// https://twitter.com/redFrik/status/445923641667358720
// notes: frame drums
// audio rating: ****
// spectrograph rating: ****
play{Splay.ar(Limiter.ar(Formlet.ar((a=LFSaw).ar((b=(1..8))+200),b*a.ar(b/29).round(0.51)+1*99,a.ar(b/9)*0.5+0.50001)/99))}// #SuperCollider


// Feb 20, 2014
// https://twitter.com/redFrik/status/436427170542809088
// notes:
// audio rating:
// spectrograph rating:
Ndef(\,{|g,f|LPF.ar(Saw.ar([g,f]),1999)}).play;{|i|Ndef(\)[i+1]=\set->Pbind(\lag,i/9.1,\g,a=Pseq((i..9)*91,inf),\f,a-i)}!19// #SuperCollider


// Feb 19, 2014
// https://twitter.com/redFrik/status/436143527584473088
// notes:
// audio rating:
// spectrograph rating:
Ndef(\,{|g,f|Pulse.ar([g,f])}).play;{|i|Ndef(\)[i=i+1]=\set->Pbind(\lag,i,\g,Pseq((i..9)*99,inf),\f,Pseq((i..91)*9,inf))}!9// #SuperCollider


// Jan 27, 2014
// https://twitter.com/redFrik/status/427912821964156928
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;b=(1..11).rotate(4)*1.011;LeakDC.ar(Splay.ar(Sweep.ar(0,b+999).fold(a.ar(11.11/b)/2-0.5,a.ar(11.1/b)/2+0.5)))}// #SuperCollider


// Jan 05, 2014
// https://twitter.com/redFrik/status/419910189215526912
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;c=(1..32);Splay.ar(SinOsc.ar(0,BPF.ar(a.ar(pi/c)*8pi*a.ar(c*a.ar(2/c,1/c,8.16,16)),c*99,a.ar(3/c)/3+0.34))/2)}// #SuperCollider


// Dec 30, 2013
// https://twitter.com/redFrik/status/417669068913537025
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;f={|i|Vibrato.ar(*if(i>0,{[a.ar(1/i)+2*f.(i-1)]},{[(99..96),(1..4),a.ar(0.1)+1,9]}))};Splay.ar(a.ar(f.(10)))}// #SuperCollider


// Dec 30, 2013
// https://twitter.com/redFrik/status/417451048672849921
// notes:
// audio rating:
// spectrograph rating:
play{c=SinOsc;mean({|i|Splay.ar({|j|CombC.ar(c.ar(j+1*99),1,c.ar(a=i*2+j/12)/2+0.5)*c.ar(i+j*99+99)*c.ar(a/3)}!8)}!8).tanh}// #SuperCollider


// Dec 29, 2013
// https://twitter.com/redFrik/status/417311008210694144
// notes:
// audio rating:
// spectrograph rating:
play{c=LFTri;mean({|i|Splay.ar([a=Saw.ar(i/98+99),DelayC.ar(a,2,c.ar(i/97+c.ar(i+1/(c.ar(i/96)*2e3+2e3),i/9,9))+1),a])}!9)}// #SuperCollider


// Dec 20, 2013
// https://twitter.com/redFrik/status/414117703163457536
// notes:
// audio rating:
// spectrograph rating:
play{Splay.ar(Formant.ar(RLPF.ar(Blip.ar(b=[4,0.5,8,16],LFSaw.ar(1/b,0,c=99,c),c,64),c,SinOsc.ar(b,b,0.5,0.6)).midicps,c))}// #SuperCollider


// Dec 13, 2013
// https://twitter.com/redFrik/status/411540562974502913
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;GVerb.ar(a.ar(1+round(a.ar(0.01),c=[1,2]/3)*99*round(a.ar(c/2)+2))*a.ar(a.ar(c))*a.ar(c/4,0,a.ar(1/c)),99)/4}// #SuperCollider


// Dec 13, 2013
// https://twitter.com/redFrik/status/411534350853734401
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;b=(1..5);Splay.ar(a.ar(b*99+round(a.ar(2/b)*40,40),b,a.ar(a.ar(0.5/b),b,a.ar(1/b,b,a.ar(2**b,b,pi)))).asin)/2}// #SuperCollider


// Dec 12, 2013
// https://twitter.com/redFrik/status/410958133008162816
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;b=(1..8)+0.505;Splay.ar(a.ar(a.ar(1/(101-b))+1*99|a.ar(a.ar(1/b,1/b,pi,a.ar(1/b)+9)/b,1/b,404,404))*3).tanh/2}// #SuperCollider


// Dec 04, 2013
// https://twitter.com/redFrik/status/408270475974815745
// notes:
// audio rating:
// spectrograph rating:
{|i|SynthDef(i,{|f|Out.ar(i,Saw.ar(f)*EnvGate())},0.123456).add;Pmono(i,\dur,c=Pn(Pshuf(i*4+4/8.fib,8))/20,\f,15/c).play}!2// #SuperCollider


// Dec 04, 2013
// https://twitter.com/redFrik/status/408219410336194560
// notes:
// audio rating:
// spectrograph rating:
SynthDef(\,{|f|Out.ar(0,LFPar.ar(f)*EnvGate()!2)}).add;PmonoArtic(\,\legato,c=Pn(Pshuf(6/8.fib,8)),\dur,c/22,\f,400/c).play// #SuperCollider


// Dec 03, 2013
// https://twitter.com/redFrik/status/408021531319476224
// notes:
// audio rating:
// spectrograph rating:
a=LFPar;play{Out.ar(5,a.ar(1)|a.ar(5)+RLPF.ar(x=Pan2.ar(InFeedback.ar(5),SinOsc.ar(5.5)),3e3,a.ar(1/25)/2+1.7));x*a.ar(99)}// #SuperCollider


// Dec 03, 2013
// https://twitter.com/redFrik/status/407912860832911361
// notes:
// audio rating:
// spectrograph rating:
a=LFTri;Ndef(\a,{CombC.ar(Ndef(\).ar,1,a.ar(2)/8+0.2,6)+9&(a.ar(1/3)*6+5)});Ndef(\,{LPF.ar(a.ar(Ndef(\a).ar*99),3e3)}).play// #SuperCollider


// Dec 03, 2013
// https://twitter.com/redFrik/status/407902302037487616
// notes:
// audio rating:
// spectrograph rating:
a=LFTri;Ndef(\a,{CombC.ar(Ndef(\).ar,1,a.ar([2,3])/8+0.2,8)+8&(a.ar(1/[3,2])*7)});Ndef(\,{a.ar(Ndef(\a).ar*[99,199])}).play// #SuperCollider


// Nov 27, 2013
// https://twitter.com/redFrik/status/405715507963101185
// notes:
// audio rating:
// spectrograph rating:
play{a=LFCub;b=(1..8);sum(CombN.ar(SinOsc.ar(c=2/b,a.ar(ceil(a.ar(c)*a.ar(1/b,0,75)).round(75),0,a.ar(0.1/c)*9)),1,1/5))/9}// #SuperCollider


// Nov 27, 2013
// https://twitter.com/redFrik/status/405695533945065472
// notes:
// audio rating:
// spectrograph rating:
play{b=(1..4);Splay.ar(CombN.ar(SinOsc.ar(1/b,Spring.ar(LFPulse.ar(pi/b),99*b,1.3e-3)*LFTri.ar(0.13/b,0,pi,2pi)),1,1/4,2))}// #SuperCollider


// Nov 26, 2013
// https://twitter.com/redFrik/status/405428776005140480
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;c=a.ar(0,a.ar(b=[2,3])*400,a.ar(b/4.1));c+a.ar(b*99*Amplitude.ar(c,0,1/7))+GrayNoise.ar(CombN.ar(c,1,b/3))/2}// #SuperCollider


// Nov 26, 2013
// https://twitter.com/redFrik/status/405416713170063360
// notes:
// audio rating:
// spectrograph rating:
play{GVerb.ar(Splay.ar(SinOsc.ar(0,Blip.ar(a=(1..5),99)*99,Blip.ar(a+2.5,a).lag2(LFSaw.ar(1/(a+2.25),2/a)+1)))/3,99,6,0.7)}// #SuperCollider


// Nov 26, 2013
// https://twitter.com/redFrik/status/405363449850384384
// notes:
// audio rating:
// spectrograph rating:
30.do{|i|play{b=13.fib;Resonz.ar(Splay.ar(Blip.ar(i+1/b,19)*ClipNoise.ar),i*[50,60]+400,LFTri.ar(1/[20,30]*i,i/9)/9+0.13)}}// #SuperCollider


// Nov 25, 2013
// https://twitter.com/redFrik/status/405027970214940672
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;Splay.ar(Pulse.ar(b=(101,202..1010)/2,RHPF.ar(a.ar(99/b)*0.9%1,a.ar(9/b,b).linexp(0,1,4,1e4),a.ar(5/b)+1.5)))}// #SuperCollider


// Nov 25, 2013
// https://twitter.com/redFrik/status/405010271082516480
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;BufWr.ar(a.ar(b=[303,404]),l=LocalBuf(64,2).clear,a.ar(b*a.ar(99/b)));BufRd.ar(2,l,a.ar(b+2)*a.ar(0.01)*12)/4}// #SuperCollider


// Nov 22, 2013
// https://twitter.com/redFrik/status/403867698204917760
// notes:
// audio rating:
// spectrograph rating:
play{CombC.ar(BLowPass.ar(Limiter.ar(LeakDC.ar(InFeedback.ar([1,0]))),2e3)+Impulse.ar(0),1,LFTri.ar(1/[6,8])*0.4+0.5)*0.99}// #SuperCollider


// Nov 19, 2013
// https://twitter.com/redFrik/status/402839691709251584
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;LeakDC.ar(a.ar([1,2],a.ar(Pitch.kr(CombN.ar(InFeedback.ar([1,0]),5,[4.8,4.7])).flop[0]-4)*2pi*a.ar(1/16)))/2}// #SuperCollider


// Nov 19, 2013
// https://twitter.com/redFrik/status/402798788609191937
// notes:
// audio rating:
// spectrograph rating:
play{a=LFPulse;a.ar(Pitch.kr(CombN.ar(InFeedback.ar([1,0]),4,4,8)).flop[0]*a.ar([6,3],0,a.ar(1.99)/8+0.3,1.2),0,a.ar(1)/2)}// #SuperCollider


// Nov 19, 2013
// https://twitter.com/redFrik/status/402777676005388289
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;a.ar(Pitch.kr(CombN.kr(InFeedback.ar([1,0]),1,1/[2,3])).flop[0]*a.ar(1/[3,4],0.1,0.3,1.2),a.ar(1/[4,5])/2)}// #SuperCollider


// Nov 19, 2013
// https://twitter.com/redFrik/status/402766558289608704
// notes:
// audio rating:
// spectrograph rating:
play{c=CombN.ar(InFeedback.ar(0,2),1,1/8,2.4,1.4);LeakDC.ar(SinOscFB.ar(Pitch.kr(c).flop[0]-0.2+(d=c.abs.lag(0.032)),1-d))}// #SuperCollider


// Nov 16, 2013
// https://twitter.com/redFrik/status/401734189067677696
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;c=a.ar([50,99],0.4);RecordBuf.ar(InFeedback.ar(0,2)+c/3,b=LocalBuf(8e4,2).clear);BufRd.ar(2,b,a.ar(c)*6e4)}// #SuperCollider


// Nov 16, 2013
// https://twitter.com/redFrik/status/401724993265885185
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;BufWr.ar(a.ar([2.995,4]*99),b=LocalBuf(3e4,2).clear,a.ar([2,6]/99)*3e4);BufRd.ar(2,b,a.ar([6,9.06]/99)*9e3)/5}// #SuperCollider


// Sep 02, 2013
// https://twitter.com/redFrik/status/374524024761487360
// notes:
// audio rating:
// spectrograph rating:
{|i|Pmono(\default,\dur,Pseq(1/[i=i+0.999,Pn(Pseq(b=(2..8)*i),Pseq(b))],inf),\amp,1/b,\freq,Pseq([b,b*i/4]*99,inf)).play}!8// #SuperCollider


// Aug 27, 2013
// https://twitter.com/redFrik/status/372400658973863936
// notes:
// audio rating:
// spectrograph rating:
a=SinOscFB;play{LeakDC.ar(Splay.ar(RHPF.ar(PinkNoise.ar(a.ar(b=1/(1..32),b)),a.ar(a.ar(b,b),1.35)+1/b*50,0.009,b))).tanh/2}// #SuperCollider


// Jul 29, 2013
// https://twitter.com/redFrik/status/361960894818811905
// notes:
// audio rating:
// spectrograph rating:
play{b=(1,3.075..16);a=SinOsc;GVerb.ar(Splay.ar(a.ar(1/b,3*a.ar(b*Duty.ar(b,0,Dseq(b+23,inf).midicps).lag(2))).tanh/5),90)}// #SuperCollider


// Jul 29, 2013
// https://twitter.com/redFrik/status/361939296485253123
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;b=(1..9).pyramid;LeakDC.ar(Pan2.ar(a.ar(d=6.01/b),a.ar(99*b),a.ar(d)%1)+Ringz.ar(a.ar(d)<d,60,0.07)).sum.tanh}// #SuperCollider


// Jul 29, 2013
// https://twitter.com/redFrik/status/361908840612114432
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;b=(4.002,9..99);mean(Pan2.ar(c=a.ar(b),c))>mean(a.ar(d=1/99)/b)*Splay.ar(a.ar(b%round(a.ar(d/b*8,b,12))*99))}// #SuperCollider


// Jul 29, 2013
// https://twitter.com/redFrik/status/361768198246371328
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;b=[3,4,8];Splay.ar(Formlet.ar(a.ar(b*99+99),a.ar(b).round(a.ar(0.05).round(1/3))*99+200,1,a.ar(b/6.011)%1)/9)}// #SuperCollider


// Jul 27, 2013
// https://twitter.com/redFrik/status/361085763649150977
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOscFB;Splay.ar({|i|Pan2.ar(a.ar(a.ar(b=1.995**i,0.5/b)+(a.ar(2/b,a.ar(b))*999),a.ar(b*1.01)),a.ar(pi/b,2))}!9/4)}// #SuperCollider


// Jul 21, 2013
// https://twitter.com/redFrik/status/359094621327998976
// notes:
// audio rating:
// spectrograph rating:
a=SinOsc;Ndef.clear.new(\,{a.ar(b=[98,99],Ndef.ar(\).lag3(Ndef.ar(\)%2/b),a.ar(1/b))});Ndef(\y,{a.ar(b+1,Ndef.ar(\))}).play// #SuperCollider


// Jul 21, 2013
// https://twitter.com/redFrik/status/358931320954560513
// notes:
// audio rating:
// spectrograph rating:
play{o=CombC.ar(Limiter.ar(HPF.ar(LocalIn.ar(2),9)+Impulse.ar(1/3,1/[4,5])),4,LFTri.ar(0.02)*1.9+2,9,0.9);LocalOut.ar(o);o}// #SuperCollider


// Jul 14, 2013
// https://twitter.com/redFrik/status/356476573077082112
// notes:
// audio rating:
// spectrograph rating:
play{f=LFTri.ar(_);e=f*4e3+4e3*f.(1.2).abs;BufWr.ar(f.([3,4]),l=LocalBuf(8e3,2).clear,e.(1/9));COsc.ar(l,99,f.(1/[7,8]))/4}// #SuperCollider


// Jul 14, 2013
// https://twitter.com/redFrik/status/356471776697528320
// notes:
// audio rating:
// spectrograph rating:
play{f=LFPar.ar(_);e=f*31+31;BufWr.ar(PanAz.ar(c=64,f.(5.04),f.(3)),l=LocalBuf(c,c),e.(1));Splay.ar(BufRd.ar(c,l,e.(200)))}// #SuperCollider


// Jul 14, 2013
// https://twitter.com/redFrik/status/356467744327213058
// notes:
// audio rating:
// spectrograph rating:
play{f=LFCub.ar(_);e=f*16+16;BufWr.ar(PanAz.ar(c=32,f.(4.008),f.(9)),l=LocalBuf(c,c),e.(4));Splay.ar(BufRd.ar(c,l,e.(99)))}// #SuperCollider


// Jul 14, 2013
// https://twitter.com/redFrik/status/356429244588503040
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;l=LocalBuf(c=99,20).clear;RecordBuf.ar(a.ar(c=(1..20)),l);GVerb.ar(HPF.ar(IndexL.ar(l,a.ar(c/45)).sum,9)/9,1)}// #SuperCollider


// Jul 13, 2013
// https://twitter.com/redFrik/status/356151997256306691
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;l=LocalBuf(b=600,9).clear;BufWr.ar(a.ar(c=(3..11)*3.5),l,a.ar(9/c,c/99)*b);Splay.ar(PlayBuf.ar(9,l,loop:1)/2)}// #SuperCollider


// Jul 13, 2013
// https://twitter.com/redFrik/status/356145002646220800
// notes:
// audio rating:
// spectrograph rating:
play{l=LocalBuf(b=3e3).clear;{|i|BufWr.ar(LFTri.ar(i+1*99),l,LFSaw.ar(i).lag(LFSaw.ar(1/9)+1)*b)}!6;PlayBuf.ar(1,l,loop:1)}// #SuperCollider


// Jul 13, 2013
// https://twitter.com/redFrik/status/356102924516077568
// notes:
// audio rating:
// spectrograph rating:
play{l=LocalBuf(b=1e4,2);{|i|BufWr.ar(a=LFTri.ar(i+1*[8,19.2]),l,a/[i+1]*b)}!3;LPF.ar(PlayBuf.ar(2,l,1/9,1,0,1).clip2,b)/2}// #SuperCollider


// Jun 18, 2013
// https://twitter.com/redFrik/status/346986901133225984
// notes:
// audio rating:
// spectrograph rating:
play{Splay.ar({|i|HPF.ar(a=Pulse;a.ar(a.ar(i+4/32).lag3(0.1,8-i)+1*99,a.ar(j=i+1)*a.ar(i+8/j)+a.ar(8/j).lag3(8)),50)}!8)/2}// #SuperCollider


// Jun 18, 2013
// https://twitter.com/redFrik/status/346974650569486336
// notes:
// audio rating:
// spectrograph rating:
play{Mix({|i|BPF.ar(a=Pulse;a.ar(i+[50,a.ar(1/16).lag2(i)+2*99]@@i,a.ar(j=i+1)*a.ar(j)+a.ar(1/12).lag3(10)),j*500)}!8)/3!2}// #SuperCollider


// May 25, 2013
// https://twitter.com/redFrik/status/338346844973305856
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;LFPulse.ar(a.ar(Duty.ar(1/8,0,Dswitch([Dseq((1..8),4),Dseq([60,1,2],[4,3])]/2,Dseq([0,1],99))*99),0,3e3,300))}// #SuperCollider


// May 23, 2013
// https://twitter.com/redFrik/status/337624317271621633
// notes:
// audio rating:
// spectrograph rating:
play{a=LFPar;Splay.ar({|i|Pluck.ar(GrayNoise.ar(a.ar(i=i+1)),a.ar(i/2)%a.ar(i/3/2),1,i*pi/3e3,3,a.ar(i/9,i,0.499,0.5))}!6)}// #SuperCollider


// May 17, 2013
// https://twitter.com/redFrik/status/335493808907231232
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;b=a.ar([199.99,200]);BPF.ar(b+DelayC.ar(b+a.ar(399.9),1,a.ar(1/99,[0,0.05])/99),999,0.1,5)};s.scope(2).style=2// #SuperCollider


// May 14, 2013
// https://twitter.com/redFrik/status/334308430045134849
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;b=a.ar(1/64)*8+9;Splay.ar({|i|a.ar(round(a.ar(i+1/32/b,i/40)+1**2*2e3+50,50),0,a.ar(i/16/b,i/48).min(0))}!64)}// #SuperCollider


// May 13, 2013
// https://twitter.com/redFrik/status/333740227799678976
// notes:
// audio rating:
// spectrograph rating:
play{a=Pulse;a.ar(a.ar(a.ar(1,b=(1..8)/9,99,9e3),a.ar(b,0.4).lag(2),a.ar(0.2*b,0.1,9,99).lag(1),300),b/(a.ar(4)+4)).mean!2}// #SuperCollider


// May 13, 2013
// https://twitter.com/redFrik/status/333739750009733121
// notes:
// audio rating:
// spectrograph rating:
play{a=Pulse;a.ar(a.ar(a.ar(1,b=(1..8)/9,9,8e3),a.ar(2/3,1/9).lag(a.ar(1)*9),a.ar(b/9,0.6,9,99),250),b/(a.ar(4)+4)).mean!2}// #SuperCollider


// May 11, 2013
// https://twitter.com/redFrik/status/333317729073381377
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;mean({|i|Ringz.ar(Blip.ar(a.ar(i+1/[3,4])>(a.ar(i+1/8)+1)*25+50,i+[2,3])*a.ar(i+1/50,i/25),i+1*99,0.1)}!50)/5}// #SuperCollider


// May 11, 2013
// https://twitter.com/redFrik/status/333261371921801217
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Splay.ar(RLPF.ar(Blip.ar(Duty.ar(1,a.ar(a.ar(1)*9+99),a.ar(7)>(a.ar(12)*0.3+0.6)*8+9),17),(1..12)*99,6e-3))/4}// #SuperCollider


// May 02, 2013
// https://twitter.com/redFrik/status/330006420479172609
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;HPF.ar(a.ar(HPZ1.ar(Amplitude.ar(InFeedback.ar(0,2)*9,0,a.ar(2)%1/6)*8e3),Decay2.ar(a.ar(0.5005)>0.93)),9)/2}// #SuperCollider


// May 01, 2013
// https://twitter.com/redFrik/status/329680702205468674
// notes:
// audio rating:
// spectrograph rating:
{|k|play{a=SinOsc;Mix({|i|LeakDC.ar(Pan2.ar(a.ar(1/9+i,0,j=a.ar(i+1/99)),a.ar(i+1+k*(j.ceil*39+39),a.ar(k+2),j)))}!9)/3}}!2// #SuperCollider


// Apr 30, 2013
// https://twitter.com/redFrik/status/329311535723839489
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;RLPF.ar(LeakDC.ar(a.ar(LeakDC.ar((1..9).sum{|x|Pan2.ar(a.ar(1/x,x/3)>0.3333,a.ar(666/x))})*999)).distort,3e3)}// #SuperCollider


// Apr 30, 2013
// https://twitter.com/redFrik/status/329305163162607616
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;distort(LeakDC.ar(a.ar(LeakDC.ar((1..9).sum{|x|Pan2.ar(a.ar(1/x)>0.51,a.ar(a.ar(x+1)*9.99+1200/x))})*4e3))/9)}// #SuperCollider


// Apr 30, 2013
// https://twitter.com/redFrik/status/329251302196523008
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;c=HPF.ar(a.ar([1,4/3],HPF.ar((1..9).sum{|x|Pan2.ar(a.ar(1/x)>0.5,a.ar(666/x))},5)),5);GVerb.ar(c,99,9)/7+c/4}// #SuperCollider


// Apr 29, 2013
// https://twitter.com/redFrik/status/328819081610399744
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;a.ar(a.ar(1/[8,9])*4+[400,202],CombC.ar(InFeedback.ar([1,0]).lagud(a.ar(1/9)+1/88,a.ar(1/8)+1/99),1,0.08,9))}// #SuperCollider


// Apr 28, 2013
// https://twitter.com/redFrik/status/328626437093466112
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;a.ar(a.ar(4)>0.2+1*[99,98],InFeedback.ar([1,0]).lagud(a.ar(0.1).abs/5,a.ar(a.ar(1/99)).abs)*a.ar([301,303]))}// #SuperCollider


// Apr 28, 2013
// https://twitter.com/redFrik/status/328620751651483648
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;a.ar(a.ar(1/[8,12])>0.9+1*[400,404],InFeedback.ar([1,0]).lagud(a.ar(b=1/(1..6)).mean,a.ar(b*1.25).mean)*4pi)}// #SuperCollider


// Apr 28, 2013
// https://twitter.com/redFrik/status/328580283874017280
// notes:
// audio rating:
// spectrograph rating:
play{a=LFPar;BLowPass.ar(a.ar(Select.kr(a.kr(1/[3,4],0,64*a.kr(5)),(60..67).midicps)),a.kr(0.04)+5*500,a.kr(1/[5,6])+1.01)}// #SuperCollider


// Apr 28, 2013
// https://twitter.com/redFrik/status/328476346550460416
// notes:
// audio rating: *****
// spectrograph rating:
play{a=SinOsc;CombN.ar(a.ar(Select.kr(a.kr(1/[8,7])*a.kr(1/30,0,9),(56,62..98).midicps),0,a.ar(1/[4,3])),1,1/[6,5],9).tanh}// #SuperCollider


// Apr 28, 2013
// https://twitter.com/redFrik/status/328471619465003009
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri;CombN.ar(VarSaw.ar(Select.kr(a.kr(1/[7,8])*a.kr(1/9,0,99),(60..79).midicps),0,a.kr(1/[3,4])%1),1,1/[5,6],8)/4}// #SuperCollider


// Apr 02, 2013
// https://twitter.com/redFrik/status/319046510102855680
// notes:
// audio rating:
// spectrograph rating:
OSCFunc({|m|a.set(\f,m[4]-0.555%4)},'/');a=play{|f=55|SendPeakRMS.kr(x=SinOsc.ar(f.lag(5)*[155,555]*f,5**f),9*f,5,'/');x/5}// #SuperCollider


// Mar 23, 2013
// https://twitter.com/redFrik/status/315468967013654528
// notes: sampling
// audio rating:
// spectrograph rating:
fork{999.do{|i|unixCmd("afplay -v"+5.0.rand+" -r"+(9.rand+1)+Platform.resourceDir+/+"sounds/a11wlk01.wav");wait(0.5.rand)}}// #SuperCollider


// Mar 15, 2013
// https://twitter.com/redFrik/status/312527579712217089
// notes:
// audio rating:
// spectrograph rating:
play{a=LFTri.ar(1/[8,7]).abs;CombC.ar(Pulse.ar(Duty.ar(a+0.1/9,0,Dseq([Dshuf((1..9)*99,7),3e3],inf)).lagud(*a/6),a),1,a,5)}// #SuperCollider


// Mar 13, 2013
// https://twitter.com/redFrik/status/311813166931800064
// notes: modem!
// audio rating:
// spectrograph rating:
play{BPF.ar(SinOsc.ar(Duty.ar(1/300,0,Dseq([Dseq([a=1270,b=2225],2e2),Drand([[1070,a],[2025,b]],[1e3,2e3])],inf))),1500,3)}// #SuperCollider


// Feb 21, 2013
// https://twitter.com/redFrik/status/304590840028872704
// notes:
// audio rating:
// spectrograph rating:
play{a=Pulse;d=Splay.ar(a.ar(Duty.ar(c=a.ar(b=(6..1),b/7.5)/8+1,0,Dseq(b*c+c.lag3(9)*66,inf))))/9;d+GVerb.ar(d.mean,25,25)}// #SuperCollider


// Feb 11, 2013
// https://twitter.com/redFrik/status/300959850370846720
// notes:
// audio rating:
// spectrograph rating:
play{a=LFNoise1;BPF.ar(Splay.ar(SinOsc.ar(0,a.ar((999,888..111),a.ar(1/(9..1),a.ar({|i|i+1/(9-i)}!9,99))))/4),1500,a.ar+1)}// #SuperCollider


// Feb 03, 2013
// https://twitter.com/redFrik/status/298081525130465280
// notes:
// audio rating:
// spectrograph rating:
{|i|play{a=Duty.ar(b=1/24,0,Dseq(Dshuf({b.linrand}!8,16+i),99));Pan2.ar(BPF.ar(Saw.ar(c=a+i+1*99,a*3),c*2,0.6)*5,i/4-1)}}!9// #SuperCollider


// Feb 01, 2013
// https://twitter.com/redFrik/status/297371798092259329
// notes:
// audio rating:
// spectrograph rating:
r{inf.do{|i|Ndef(\,{VarSaw.ar(Duty.ar(1/12,0,Dseq((12..0)*(i%63+99)),2)*[1,1.01],0,i/9%9/9)/9}).play.spawn;wait(1/3)}}.play// #SuperCollider


// Dec 23, 2012
// https://twitter.com/redFrik/status/282859964601602048
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;Splay.ar(a.ar(PulseCount.ar(f=InFeedback.ar(0,2).sum)%999+(60,63.0005..99)*a.ar(2**f)*2+[3,4],f>0*f*9)).tanh}// #SuperCollider


// Dec 17, 2012
// https://twitter.com/redFrik/status/280671780165804033
// notes:
// audio rating:
// spectrograph rating:
play{Splay.ar({a={LFSaw.kr(0.05.rand2,0,1.0.rand)}!3;BLowPass4.ar(Saw.ar(a@0*250+300,a[2].max(0)),a@1*2e3+2100,0.025)}!99)}// #SuperCollider


// Dec 14, 2012
// https://twitter.com/redFrik/status/279720873374650368
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;Formant.ar(b=a.ar(a.ar(a.ar(a.ar(0.1)+1.0905*9)/99)*999)*999,c=CombN.ar(b,1,[0.1,0.11]),CombN.ar(c,1,0.19))/3}// #SuperCollider


// Dec 08, 2012
// https://twitter.com/redFrik/status/277524002434600960
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;Splay.ar({|i|j=i/700;a.ar(j,a.ar(j*2,a.ar(j*3,a.ar(j*4,a.ar(j*5,http://t.co/8Bpx88ZE),2pi),2pi),2pi))}!15)/2}// #SuperCollider


// Dec 07, 2012
// https://twitter.com/redFrik/status/277107810909683713
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;d=a.ar(12*a.ar(9))%1/4;c=Amplitude.ar(InFeedback.ar(0),d,d)+a.ar(d*d+[32.01,32]);BBandPass.ar(a.ar(0,c*9,c))}// #SuperCollider


// Dec 06, 2012
// https://twitter.com/redFrik/status/276813725338587136
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;b=InFeedback.ar(0,2);a.ar(9,a.ar(Pitch.kr(Balance2.ar(b[0],b[1],a.ar(12)),execFreq:99).flop[0])+a.ar(3,b,2))}// #SuperCollider


// Dec 05, 2012
// https://twitter.com/redFrik/status/276170271214428161
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;f=InFeedback.ar(0,2);Pan2.ar(a.ar(a.ar(b=(1..9))*b+99,f/(9-b),a.ar(a.ar(b,f))).sum.sin,a.ar(a.ar(2.001)*12))}// #SuperCollider


// Dec 04, 2012
// https://twitter.com/redFrik/status/275991722880798720
// notes: sounds like a subway
// audio rating:
// spectrograph rating: ****
play{a=LFCub;(50..85).midicps.clump(2).collect{|x,y|a.ar(TRand.ar(x,y,Dust.ar(b=a.ar(y/x).exprange(1,5e3))),0,b/5e3)}.mean}// #SuperCollider


// Nov 30, 2012
// https://twitter.com/redFrik/status/274311133924560896
// notes: BASS!
// audio rating:
// spectrograph rating: ****
{|i|b=SinOsc;play{a=DelayC.ar(InFeedback.ar(1-i),6,b.ar(1e-3*(b.ar(1,i)),i,3,3));b.ar(45+[a/8,a/9]+b.ar(0.123),a*3)/5!2}}!2// #SuperCollider


// Nov 29, 2012
// https://twitter.com/redFrik/status/274299694841200640
// notes:
// audio rating:
// spectrograph rating:
{|i|play{a=DelayC.ar(InFeedback.ar(1-i),8,LFSaw.ar(1e-5*i+1e-4*(LFSaw.ar(0.1)>0),i,4,4));SinOsc.ar(99+[0,a/9],a*pi)/5!2}}!2// #SuperCollider


// Nov 29, 2012
// https://twitter.com/redFrik/status/274292744950796289
// notes:
// audio rating:
// spectrograph rating:
r{loop{x=play{c=c?1%8+1;a=DelayN.ar(InFeedback.ar(0,2),1,1);SinOsc.ar(c*99+[0,2],a[1..0])/4};wait(9-c);x.release(16)}}.play// #SuperCollider


// Nov 29, 2012
// https://twitter.com/redFrik/status/274281727353040896
// notes:
// audio rating:
// spectrograph rating:
r{loop{x=play{a=DelayN.ar(LPF.ar(InFeedback.ar(0,2),z=1.rrand(9)*99));SinOsc.ar(z+[0,3],a*pi)/2};6.wait;x.release(9)}}.play// #SuperCollider


// Nov 23, 2012
// https://twitter.com/redFrik/status/272102220118511616
// notes:
// audio rating:
// spectrograph rating:
play{a=LFSaw;b=LocalIn.ar;LocalOut.ar(c=Limiter.ar(CombC.ar(a.ar(d=b+3.3*99)*a.ar(a.ar(d/9)*99),2,a.ar(1/d)/2+1,9)));c/2!2}// #SuperCollider


// Nov 23, 2012
// https://twitter.com/redFrik/status/272084931948204032
// notes: laughing
// audio rating: ***
// spectrograph rating: ****
play{a=LFTri;b=LocalIn.ar;LocalOut.ar(c=Limiter.ar(CombC.ar(a.ar(400)*a.ar(d=b+2),1,a.ar((2..5)/d/d/d).mean*0.5+0.5)));c!2}// #SuperCollider


// Nov 23, 2012
// https://twitter.com/redFrik/status/272082117436010496
// notes: modem
// audio rating:
// spectrograph rating:
play{a=LFTri;b=LocalIn.ar;LocalOut.ar(c=Limiter.ar(CombC.ar(a.ar(d=b+1)*a.ar(d*999),1,a.ar((2..5)/3).mean/2+0.5,6)));c/2!2}// #SuperCollider


// Nov 11, 2012
// https://twitter.com/redFrik/status/267628516105936898
// notes:
// audio rating:
// spectrograph rating: ***
{|i|a=VarSaw;b=i/8;play{Pan2.ar(a.ar(b*666+a.ar(b+0.03,b),0,b+0.06,a.ar(b+1,0,b+0.1,6+b,7+b)).sin.tanh,a.ar(b+1,b),0.2)}}!8// #SuperCollider


// Nov 09, 2012
// https://twitter.com/redFrik/status/266890905984847872
// notes: insect like, spectrograph like spiderwebs in grass
// audio rating: ***
// spectrograph rating: *****
play{a=Blip;b=LFSaw;CombN.ar(a.ar(a.ar(b.ar(1/[9,99])*1e3+4e3,b.ar(1/[23,24])*4+5,b.ar(1/[5,6])+b.ar(1/[8,9])*9)),0.3,0.3)}// #SuperCollider


// Oct 29, 2012
// https://twitter.com/redFrik/status/263022077903249409
// notes: calliope
// audio rating:
// spectrograph rating:
play{Mix(Pan2.ar(Formlet.ar(Dust.ar(b=(1..8)),b*99,b/99,b/9),SinOsc.ar(b),LFSaw.ar(9.5-b,b/9,LFTri.ar(b/5)*4).max(0)).sin)}// #SuperCollider


// Oct 22, 2012
// https://twitter.com/redFrik/status/260500152823980032
// notes:
// audio rating:
// spectrograph rating:
play{a=LFPulse;Splay.ar(Pulse.ar((1..10)*a.ar(1/24+a.ar(1/3)*12,0,1/9,a.ar(1/12,0,0.5,9,48)).abs+6).reduce(\mod).softclip)}// #SuperCollider


// Oct 21, 2012
// https://twitter.com/redFrik/status/259965518776242176
// notes: dripping cave
// audio rating: ***
// spectrograph rating: ****
play{FreeVerb.ar(Splay.ar(BBandPass.ar(Blip.ar(b=(1..8)+1,LFTri.ar(1/b)*9e3,LFTri.ar(3/4/b).max(0)),b*999,1/b),2,3),0.3,1)}// #SuperCollider


// Sep 25, 2012
// https://twitter.com/redFrik/status/250604693028499457
// notes:
// audio rating:
// spectrograph rating:
play{a=SinOsc;LPF.ar(LeakDC.ar(a.ar([98,99],a.ar([8,9],a.ar(1/[88,99],0,2pi),pi).lag(a.ar([9,8])),a.ar(1/[8,9])*9)%1),9e3)}// #SuperCollider


// Aug 23, 2012
// https://twitter.com/redFrik/status/238728457511636992
// notes: great ambient patch: ocean and bowed bells, spectrograph like ocean at sunset
// audio rating: *****
// spectrograph rating: *****
play{a=LFNoise2.kr(1/(9..17));Splay.ar(Ringz.ar(BPF.ar(Dust2.ar(a.abs*1e4),a.exprange(99,1e4),1.1-a),(9..1)*99,a+1.1,a)/5)}// #SuperCollider


// Jul 29, 2012
// https://twitter.com/redFrik/status/229645521898323968
// notes: brutal ear rape, spectrograph plaid
// audio rating:
// spectrograph rating:
play({Duty.ar(1/9600,0,Dseq((0..255).collect{|i|[1]++(1-i.asBinaryDigits.reverse)++[0]}.flat,inf),2)!2},s,0,0)// #SuperCollider talks serial


// Jun 08, 2012
// https://twitter.com/redFrik/status/211151276619210753
// notes: spectrograph is bumblebee heat vision
// audio rating: ***
// spectrograph rating: ***
play{a=SinOsc;a.ar(a.ar([1,2,4,8]/4*999).sum*50+[2,1]/3,a.ar(60,0,a.ar([1,2]/3)*a.ar(1/8,0,a.ar(1/8)*8)).tanh*a.ar(4)*6)/2}// #SuperCollider


// May 24, 2012
// https://twitter.com/redFrik/status/205703547973672960
// notes: beep bop boop robot in a cave
// audio rating: ****
// spectrograph rating: ****
format(a="c=SinOsc;play{FreeVerb.ar(c.ar(0,c.ar(Duty.ar(v=1/8,0,Dseq("+($%!96)+",inf)!2))),v,1)}",*a.ascii-96*96).interpret// #SuperCollider


// May 12, 2012
// https://twitter.com/redFrik/status/201322949658161153
// notes:
// audio rating:
// spectrograph rating:
a=LFTri;play{CombN.ar(SinOsc.ar(Saw.ar(3,128,128),Saw.ar([3,4],a.ar(a.kr(0.1,0,8,12),0,32,128)).sin)/4,1,1/6,a.kr(1/32)+1)}// #SuperCollider


// May 06, 2012
// https://twitter.com/redFrik/status/199137670037897217
// notes: lazer house, gets polyrhytmic
// audio rating: ****
// spectrograph rating: ***
Pbind(\freq,Pseq("SUPERCOLLIDER".ascii,inf)*Pstutter(64,Pseq([3,4,5],inf))*[1,2.045],\dur,0.03,\amp,Pseq([0,0.1],inf)).play// #SuperCollider


// May 06, 2012
// https://twitter.com/redFrik/status/199128874913759232
// notes: bzzzzzzzzzzzzz
// audio rating:
// spectrograph rating:
{Splay.ar(BLowPass.ar(Impulse.ar("sunday".ascii),LFTri.ar(3/"live".ascii)*1800+1900,LFTri.ar(4/"coding".ascii)+1.01))}.play// #SuperCollider


// MMM DD, 2022
// https://twitter.com/redFrik/status/
// notes:
// audio rating:
// spectrograph rating:

