*Ex37_create_mats_from_SDS.sas (Part 1);
PROC IML;
  USE sashelp.class;
  READ all var _num_ INTO c_m_nummat
        where(sex='M');
  CLOSE sashelp.class;
  PRINT c_m_nummat;
QUIT;
*Ex37_create_mats_from_SDS.sas (Part 2);
PROC IML;
  USE sashelp.class;
  READ all var _num_ INTO nummat  where(sex='M');
  READ all var {name} INTO charmat where(sex='M');
         cols = {'Age' 'Height' 'Weight'};
  CLOSE sashelp.class;
  PRINT nummat [rowname=charmat 
                colname=cols
                label= ' '
                format=5.0];
QUIT;
*Ex37_create_mats_from_SDS.sas (Part 3);
PROC IML;
  USE sashelp.class;
  READ all var _num_ where(sex='M');
  CLOSE sashelp.class;
  PRINT age height weight;
QUIT;
*Ex37_create_mats_from_SDS.sas (Part 4);
PROC IML;
  USE sashelp.class where(name=:'J');
  READ all var {name sex} INTO class_J_mat;
  CLOSE sashelp.class;
QUIT;
*Ex37_create_mats_from_SDS.sas (Part 5);
PROC IML;
  USE sashelp.class;
  READ all var _num_ INTO num_mat;
  READ all var _char_ INTO char_mat;
  CLOSE sashelp.class;
  PRINT num_mat char_mat;
QUIT;





