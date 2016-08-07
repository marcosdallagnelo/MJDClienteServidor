unit uIBaseRepository;

interface

uses System.Generics.Collections;

type
  IBaseRepository<T: class> = interface['{511ACC5B-9E45-4F6E-B1CE-1C5E1D036A87}']
    procedure Incluir(model: T);
    procedure Alterar(model: T);
    procedure Excluir(model: T);
    function Listar: TObjectList<T>;
  end;

implementation

end.
