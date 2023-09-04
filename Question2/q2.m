clc
clear

%read the table
t = readtable('worldcities-short.xlsx');
t.country = categorical(t.country);
i = (t.country == 'Iran') | (t.country == 'Japan') | (t.country == 'Iraq') | (t.country == 'Turkey');
t=t(i,:);
filename = 'cities_distance.xlsx';
cities = table2array(t(:,1));
xlswrite(filename,cities,'Sheet1','A2');
xlswrite(filename,cities.','Sheet1','B1');
tt = table2array(t(:,2:3));

%compute the distances
r = 6371;
mat = [];
for i = 1:size(tt,1)
    row_p = tt(i,:);
    vec = [];
    for j = 1:size(tt,1)
        row_a = tt(j,:);
        ph1 = deg2rad(row_p(1,1));
        ph2 = deg2rad(row_a(1,1));
        lambda1 = deg2rad(row_p(1,2));
        lambda2 = deg2rad(row_a(1,2));
        delta_lambda = abs(lambda1-lambda2);
        delta_sigma = acos( sin(ph1)*sin(ph2) + cos(ph1)*cos(ph2)*cos(delta_lambda) );
        d = r*delta_sigma;
        vec = [vec,d];
    end    
    mat=[mat;vec];
end
xlswrite(filename,mat,'Sheet1','B2');

%part 1
indx = find(ismember(cities,'Tehran'));
my_vec=mat(indx,:);
my_vec(my_vec == 0 ) = NaN;
[my_min, indx_min]=min(my_vec);
[my_max, indx_max]=max(my_vec);
disp("Min distance to Tehran:")
disp(cities(indx_min))
disp(my_min)
disp("Max distance to Tehran:")
disp(cities(indx_max))
disp(my_max)

%part 2
%all available cities are less than 20000km to Tehran! change 20000 to 2000
indx=find(my_vec<2000);
disp('number of citier closer than 2000km to Tehran: ')
disp(size(indx,2))
disp(cities(indx))

%part 3
i=(t.country=='Japan');
[val , indx]=min(my_vec(i));
disp('nearest Japanese city to Tehran: ')
disp(cities(indx))
disp(val)

%part 4
i=(t.country=='Iran');
j=(t.country=='Iraq');
new_mat=mat(i,j);
val = min(new_mat(:));
[r,c] = find(new_mat==val);
a=find(i>0);
b=find(j>0);
disp('Iran-Iraq closest cities:')
disp(cities(a(r)))
disp(cities(b(c)))
disp(val)

j=(t.country=='Turkey');
new_mat=mat(i,j);
val = min(new_mat(:));
[r,c] = find(new_mat==val);
a=find(i>0);
b=find(j>0);
disp('Iran-Tuekey closest cities:')
disp(cities(a(r)))
disp(cities(b(c)))
disp(val)

