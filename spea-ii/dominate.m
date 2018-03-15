function result = dominate(a, b, problem)

  result = 1;
  for i = 1:problem.objCount
    if problem.objectives{i}(a) > problem.objectives{i}(b)
      result = -1;
      break;
    end
  end  

end