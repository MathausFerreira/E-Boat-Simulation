function Img = parametrizacaoFigura()
%%  OPÇÕES DA FIGURA
% Screen = [0.2 0.2 .65 .55];
Screen = [0.2 0.2 .25 .55];
Img.figOpt = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};

Screen = [0.1 0.1 .65 .75];
Img.figOpt2L = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};

% quando tem 3 linhas de saida na figura
Screen = [0.2 0.2 .65 .65];
Img.figOpt3L = {'color','w','Units','Normalized','PaperPositionMode','auto',...
    'Position',Screen,'InnerPosition',Screen};



Img.Label = {'Interpreter','latex','FontWeight','bold','FontName', 'Times New Roman','FontSize',15};

end