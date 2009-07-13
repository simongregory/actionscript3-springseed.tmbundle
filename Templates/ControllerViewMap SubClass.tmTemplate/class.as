// AS3.Springseed

package org.springseed.example.controller {

	import org.springseed.navigator.controller.ControllerViewMap;
	import org.springseed.example.controller.HomeController;
	import org.springseed.example.controller.ResourceNotFoundController;
	import org.springseed.example.view.HomeView;
	import org.springseed.example.view.ResourceNotFoundView;

	public class ExampleControllerViewMap extends ControllerViewMap {

		public function ExampleControllerViewMap()
		{
			super();
		}

		override public function getResourceNotFoundController():Class
		{
			return ResourceNotFoundController;
		}

		override public function getRootRequestController():Class
		{
			return HomeController;
		}

		override protected function initialize():void
		{
			super.initialize();
			addMap( ResourceNotFoundController, ResourceNotFoundView );
			addMap( HomeController, HomeView );
		}
	}
}
