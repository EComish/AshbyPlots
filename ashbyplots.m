data = readtable('mechdata.csv')
i = 1
H = height(data)

prompt = 'What on y-axis? 2 = strength, 4 = toughness, 6 = diameter, 8 = extensibility, 10 = stiffness, 12 = 1/diameter'
a = input(prompt)       %these numbers relate to the columns in the csv file
prompt = 'What on x-axis? 2 = strength, 4 = toughness, 6 = diameter, 8 = extensibility, 10 = stiffness, 12 = 1/diameter'
b = input(prompt)



for i = 1:H    %loop through all rows of table
    xc = table2array(data(i,b)) %data points = centres of ellipses
    yc = table2array(data(i,a))
    r1 = table2array(data(i,b+1)); %errors = x and y radii of ellipses
    r2 = table2array(data(i,a+1));
    x = r1*sin(-pi:0.001*pi:pi) + xc;   %equation of ellipses 
    y = r2*cos(-pi:0.001*pi:pi) + yc;
    
    type = char(table2array(data(i,14)));
    
    c = [0 0 0];    
    trans = 0;
    switch type       %colouring the circles based on value in column 14
        case 'Wet'          % Dark blue
            c = [0 0.5 1];
            trans = 0.7;
        case 'Dry'          % Cyan
            c = [0.3 1 1];
            trans = 0.7;
        case 'Microfluidic (Wet)'   % Purple
            c = [0.6 0.2 1];
            trans = 0.7;
        case 'Microfluidic (Dry)'   % Red
            c = [1 0.2 0.2];
            trans = 0.9;
        case 'Self Assembly'        % Orange
            c = [1 0.6 0.2];
            trans = 0.9;
        case 'Natural'              %green
            c = [0 0.7 0];      
            trans = 0.7;
        case 'Man-Made'             %black
            c = [0 0 0];       
            trans = 0.7;
            
    end
    
    
    fill(x, y, c, 'FaceAlpha', trans)
    
    hold on
    i = i+1;
    
end
set(gca,'FontSize',12)
switch a       %choosing right x and y labels for plots
    case 2
        ylabel('Strength / MPa')
    case 4
        ylabel('Toughness / MJm^-^3')
    case 6
        ylabel('Diameter / \mum')
    case 8 
        ylabel('Extensibility / %')
    case 10
        ylabel('Stiffness / GPa')
    case 12
        ylabel('1/Diameter / \mum^-^1')
end

switch b
    case 2
        xlabel('Strength / MPa')
    case 4
        xlabel('Toughness / MJm^-^3')
    case 6
        xlabel('Diameter / \mum')
    case 8 
        xlabel('Extensibility / %')
    case 10
        xlabel('Stiffness / GPa')
    case 12
        xlabel('1/Diameter / \mum^-^1')
end

set(gca, 'XScale', 'log')
set(gca, 'YScale', 'log')
print(gcf,'figure1.png','-dpng','-r300');