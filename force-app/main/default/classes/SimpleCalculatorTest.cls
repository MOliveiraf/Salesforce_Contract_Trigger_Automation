@isTest
public class SimpleCalculatorTest {
    @isTest static void testAdd() {
        Integer result = SimpleCalculator.add(2, 3);
        System.assertEquals(5, result, 'A adição deveria retornar 5');
    }
}