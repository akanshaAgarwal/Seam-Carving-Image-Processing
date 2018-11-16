seams=[0,50,100,150,200,250];
t1=[0,25,46,64,77,91];
t2=[0,21,38,51,62,76];

a=plot(seams,t1,'g',seams,t2,'b');
legend('Our Proposed Strategy for SC','Standard Seam Carving Methods');
xlabel('Number of Seams to carve');
ylabel('Time Required for carving');
title('Time vs number of Seam curve');
savefig('plotSeamVsTime.fig');