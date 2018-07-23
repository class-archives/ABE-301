% Kathryn Atherton
% Margaret Hegwood
% Audrey Conrad 
% Kristen Palmer
% ABE 301 Extra Credit M&M Model 

clc;
clear;

fprintf('What is being requested?\n     Number of M&Ms in a fun-sized bag.\n');
fprintf('Identify parameters and variables. Give each a symbolic name.\n');
fprintf('     Volume of bag: b\n');
fprintf('     Volume of M&M: m\n');
fprintf('     Number of M&Ms: n\n');
fprintf('Identify fundamental relationships between parameters.\n');
fprintf('     b/m = n\n\n');

fprintf('Iteration 1:\n');
fprintf('Assumptions:\n');
fprintf('     The shape of the bag is a cuboid with a face that is 8 cm by 8 cm.\n');
fprintf('     The shape of the M&M is a sphere with a radius of 0.5 cm.\n');
fprintf('     The height of the bag is equal to the diameter of one M&M.\n');
fprintf('     There is no empty space in the bag.\n');

b_length = 8; % cm, estimation based on looking at bag
m_radius = 0.5; % cm, estimation found on class slides from 1/10 lecture

b = b_length * b_length * 2 * m_radius;
m = (4 / 3) * pi * (m_radius ^ 3);
n = b / m;

fprintf('%d M&Ms can fit in the bag.\n\n', round(n));

fprintf('Iteration 2:\n');
fprintf('Assumptions:\n');
fprintf('     The shape of the bag is a cuboid with a face that is 8 cm by 8 cm.\n');
fprintf('     The shape of the M&M is an oblate spheroid with a short radius of 0.3 cm and a long radius of 0.6 cm.\n');
fprintf('     The height of the rectangular prism is equal to the shorter diameter of the M&M.\n');
fprintf('     There is no empty space in the bag.\n');

m_radius_short = 0.3; % cm, estimation found on class slides from 1/10 lecture
m_radius_long = 0.6; % cm, estimation found on class slides from 1/10 lecture

b = b_length * b_length * 2 * m_radius_short;
m = (4 / 3) * pi * (m_radius_long ^ 2) * (m_radius_short); % formula found on class slides from 1/10 lecture
n = b / m;

fprintf('%d M&Ms can fit in the bag.\n\n', round(n));

fprintf('Iteration 3:\n');
fprintf('Assumptions:\n');
fprintf('     The shape of the bag is a cuboid with a face that is 8 cm by 8 cm.\n');
fprintf('     The shape of the M&M is an oblate spheroid with a short radius of 0.3 cm and a long radius of 0.6 cm.\n');
fprintf('     The height of the rectangular prism is equal to the shorter diameter of the M&M.\n');
fprintf('     Void space exists in the bag.\n');
fprintf('     The M&Ms are packed in a hexogonal fasion in one flat layer (hexoganal planar packing pattern).\n')

d = 0.9069; %  regular hexagonal lattice packing density, Axel Thue Theorem (http://math.stmarys-ca.edu/wp-content/uploads/2017/07/Roshni-Mistry.pdf)
n = b / (4 * pi * (m_radius_long ^ 2) * (m_radius_short) / d);

fprintf('%d M&Ms can fit in the bag.\n\n', round(n));

fprintf('Iteration 4:\n');
fprintf('Assumptions:\n');
fprintf('     The shape of the bag is a rectangular prism with a face that is 7.62 cm by 9.525 cm.\n');
fprintf('     The shape of the M&M is an oblate spheroid with a short radius of 0.3 cm and a long radius of 0.6 cm.\n');
fprintf('     The height of the rectangular prism is equal to the shorter diameter of the M&M.\n');
fprintf('     Void space exists in the bag.\n');
fprintf('     The M&Ms are packed in a hexogonal fasion in one flat layer (hexoganal planar packing pattern).\n')

b_length = 7.62; % cm, candywarehouse.com (https://www.candywarehouse.com/peanut-mms-candy-fun-size-packs-5lb-bag/)
b_width = 9.525; % cm, candywarehouse.com (https://www.candywarehouse.com/peanut-mms-candy-fun-size-packs-5lb-bag/)

b = b_length * b_width * 2 * m_radius_short;
n = b / (4 * pi * (m_radius_long ^ 2) * (m_radius_short) / d);

fprintf('%d M&Ms can fit in the bag.\n\n', round(n));

fprintf('Iteration 5:\n');
fprintf('Assumptions:\n');
fprintf('     The shape of the bag is a "pillow" with a face that is 7.62 cm by 9.525 cm.\n');
fprintf('     The shape of the M&M is an oblate spheroid with a short radius of 0.3 cm and a long radius of 0.6 cm.\n');
fprintf('     Void space exists in the bag.\n');
fprintf('     The M&Ms are packed in a 3-D hexogonal fasion.\n');

d_full = 1.209; % estimation found on class slides from 1/10 lecture

b = (b_width ^ 3) * (b_length / (pi * b_width) - 0.142 * (1 - 10 ^ (-1 * b_length / b_width))); % Robin, 2004 (http://mathworld.wolfram.com/PaperBag.html)
n = b / (4 * pi * (m_radius_long ^ 2) * (m_radius_short) / d_full);

fprintf('%d M&Ms can fit in the bag.\n\n', round(n));

fprintf('Iteration 6:\n');
fprintf('Assumptions:\n');
fprintf('     The shape of the bag is a "pillow" with a face that is 7.62 cm by 9.525 cm.\n');
fprintf('     However, 0.7 centimeters on each side of the aforementioned face is used to seal the bag and does not contribute to the volume.\n');
fprintf('     The shape of the M&M is an oblate spheroid with a short radius of 0.3 cm and a long radius of 0.6 cm.\n');
fprintf('     The height of the rectangular prism is equal to the shorter diameter of the M&M.\n');
fprintf('     Void space exists in the bag.\n');
fprintf('     The M&Ms are packed in a 3-D hexogonal fasion.\n');

b_length = b_length - 0.7; % 0.7 cm measured
b_width = b_width - 0.7;

b = (b_length ^ 3) * (b_width / (pi * b_length) - 0.142 * (1 - 10 ^ (-1 * b_width / b_length)));
n = b / (4 * pi * (m_radius_long ^ 2) * (m_radius_short) / d_full);

fprintf('%d M&Ms can fit in the bag.\n\n', round(n));

fprintf('Iteration 7:\n');
fprintf('Assumptions:\n');
fprintf('     The shape of the bag is a "pillow" with a face that is 7.62 cm by 9.525 cm.\n');
fprintf('     However, a quarter of a centimeter on each side of the aforementioned face is used to seal the bag and does not contribute to the volume.\n');
fprintf('     The shape of the M&M is an oblate spheroid with a short radius of 0.3 cm and a long radius of 0.6 cm.\n');
fprintf('     Void space exists in the bag.\n');
fprintf('     Mars Inc. packages the M&Ms in a planar hexoganal pattern to allow for easier bulk packaging and to prevent candy breakage.\n');

n = b / (4 * pi * (m_radius_long ^ 2) * (m_radius_short) / d);


fprintf('%d M&Ms can fit in the bag.\n\n', round(n));

fprintf('Iteration 8:\n');
fprintf('Assumptions:\n');
fprintf('     The shape of the bag is a "pillow" with a face that is 7.62 cm by 9.525 cm.\n');
fprintf('     However, a quarter of a centimeter on each side of the aforementioned face is used to seal the bag and does not contribute to the volume.\n');
fprintf('     The shape of the M&M is an oblate spheroid with a short radius of 0.3 cm and a long radius of 0.6 cm.\n');
fprintf('     Void space exists in the bag.\n');
fprintf('     Mars Inc. packages the M&Ms in a planar hexoganal pattern to allow for easier bulk packaging and to prevent candy breakage.\n');
fprintf('     Mars Inc. only fills its bags to 33%% (one-third) of its maximum capacity for flat packing to allow for easier packaging and to prevent candy breakage.\n');

b = b * 0.33; % estimation based on feasibility of the answer
n = b / (4 * pi * (m_radius_long ^ 2) * (m_radius_short) / d);

fprintf('%d M&Ms can fit in the bag.', round(n));