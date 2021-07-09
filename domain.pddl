(define (domain driving)
    (:requirements :strips :equality)
    (:predicates
        ; Static predicates (predicates that do not change over time)
      	(IsVehicle ?obstacle)
        (IsPedestrian ?obstacle)
        
        ; Fluent predicates (predicates that change over time, which describes the state of the sytem)
    	  (AtPose ?cup ?block)
    	  (Grasped ?cup ?grasp)
        
        ; Derived predicates (predicates derived from other predicates, defined with streams)
    	  (Unsafe ?control)
    	  (Holding ?cup)
      	(On ?cup ?block)

    	  ; External predicates (evaluated by external boolean functions)
      	(Collision ?control ?gripper ?pose)
    )
